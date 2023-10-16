page 50295 "Student Detail Card-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                     Remarks
    // 1         CSPL-00092    29-05-2019    OnOpenPage                                  Flag Condition Base True of false
    // 2         CSPL-00092    29-05-2019    OnAfterGetRecord                            Flag Condition Base True of false
    // 3         CSPL-00092    29-05-2019    OnNewRecord                                 Flag false
    // 4         CSPL-00092    29-05-2019    Student No. - OnAssistEdit                  Function Call for select no. series
    // 5         CSPL-00092    29-05-2019    Category - OnValidate                       Flag Condition Base True of false
    // 6         CSPL-00092    29-05-2019    <Action1102155122> - OnAction               Import Image
    // 7         CSPL-00092    29-05-2019    <Action1102155123> - OnAction               Export Image
    // 8         CSPL-00092    29-05-2019    <Action1102155124> - OnAction               Delete Image
    // 9         CSPL-00092    29-05-2019    UpdateStudentGrade - OnAction               Update Student wise CPGA
    // 10        CSPL-00092    29-05-2019    Student Un Transfer - OnAction              Report Run
    // 11        CSPL-00092    29-05-2019    Send on Boarding Email - OnAction           Generate Portl User
    // 12        CSPL-00092    29-05-2019    Student Data Upload - OnAction Run          XMLPort
    // 13        CSPL-00092    29-05-2019    Update Student Details - OnAction           Run XMLPort
    // 14        CSPL-00092    29-05-2019    Update Student Subject (Core) - OnAction    Update Student Subject
    // 15        CSPL-00092    29-05-2019    Academic Details - OnAction                 Update Student Subject
    // 16        CSPL-00092    29-05-2019    Edit - OnAction                             Condition Based Flag True false
    // 17        CSPL-00092    29-05-2019    Total Credit Earned - OnAction              Find total Credit
    // 18        CSPL-00092    29-05-2019    Calculate Results - OnAction                Page Run

    Caption = 'Student Card';
    DeleteAllowed = true;

    UsageCategory = None;
    PromotedActionCategories = 'New,Process,Navigate,Admissions,Registrar/Academics,Clinical,Student Services,Bursar/Finance,Financial Aid,EED Pre-Clinical,EED Clinical Science,Graduate Affairs,Feedback,OLR Finance';
    Editable = true;
    PageType = Card;
    SourceTable = "Student Master-CS";

    layout
    {
        area(content)
        {
            field(""; RegistrarHold)
            {
                Caption = ' ';
                ApplicationArea = all;
                Style = Attention;
                Visible = RegistrarBool;
                Editable = false;
            }

            group("Hold Information")/////GAURAV//12.12.22//////
            {
                field("Housing Hold"; Rec."Housing Hold")
                {
                    Caption = 'Admissions Hold';
                    ApplicationArea = All;
                }
                field("Bursar Holds"; Rec."Bursar Hold")
                {
                    ApplicationArea = All;
                }
                field("Financial Aid Hold"; Rec."Financial Aid Hold")
                {
                    ApplicationArea = All;
                    Visible = FinancialAid_GBoo;
                }
                field("Registrar Hold"; Rec."Registrar Hold")
                {
                    ApplicationArea = All;
                }
                field("Immigration Hold"; Rec."Immigration Hold")
                {
                    Caption = 'Student Services Hold';
                    ApplicationArea = All;
                }
                field("OLR Finance Hold"; Rec."OLR Finance Hold")
                {
                    ApplicationArea = All;
                }
                field("SAFI Sync"; Rec."SAFI Sync")
                {
                    ApplicationArea = All;
                    Editable = false;
                }



            }
            group("General")
            {
                Caption = 'General';
                Editable = True;

                field("Original Student No."; Rec."Original Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Student No."; Rec."No.")
                {
                    ApplicationArea = All;
                    //Visible = false;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        //Code added for Function Call for select no. series::CSPL-00092::29-05-2019: Start
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                        //Code added for Function Call for select no. series::CSPL-00092::29-05-2019: End
                    end;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maiden Name"; Rec."Maiden Name")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    Visible = Social;
                    Caption = 'Social Security No.';
                }
                field("Status Manually Changed by"; Rec."Status Manually Changed by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Status Manually Changed on"; Rec."Status Manually Changed on")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Caption = 'Course Code';
                    ShowMandatory = true;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                    Caption = 'Course Name';
                }
                field("Date of Joining"; Rec."Date of Joining")
                {
                    ApplicationArea = All;
                    Caption = 'DOJ-Class Start Date';
                }

                field("Date of Leaving"; Rec."Date of Leaving")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Enrollment Order"; Rec."Enrollment Order")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("SalesForce ID"; Rec."18 Digit ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'SalesForce ID';
                }
                field("Parent Student No."; Rec."Parent Student No.")
                {
                    ApplicationArea = All;
                    trigger onvalidate()
                    begin
                        if Rec."Enrollment No." <> '' then
                            error('"Parent Student No. cannot be assigned if Enrollment No. exists."');
                    end;
                }
                field("No. of Enrollments"; Rec."No. of Enrollments")
                {
                    ApplicationArea = all;

                }
                field("Name as on Certificate"; Rec."Name as on Certificate")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Social Security No"; SocialSecurity)
                {
                    ApplicationArea = All;
                    Visible = SocialSec;
                    Editable = false;
                    Caption = 'Social Security No.';
                }
                Field("Incoming Cohort"; Rec."Incoming Cohort")
                {
                    ApplicationArea = All;
                }
                Field(Section; Rec.Section)
                {
                    ApplicationArea = All;

                }
                Field("Blackboard Synch Status"; Rec."Blackboard Synch Status")
                {
                    ApplicationArea = All;
                }
                Field("Teaching Assistant"; Rec."Teaching Assistant")
                {
                    ApplicationArea = All;
                }

            }

            Group("Parent Information")
            {
                field("Fathers Name"; Rec."Fathers Name")
                {
                    ApplicationArea = All;
                    Editable = FatherEnable;

                }

                field("Father Contact Number"; Rec."Father Contact Number")
                {
                    ApplicationArea = All;
                    Editable = FatherContactNumber;
                }
                field("Father Email ID"; Rec."Father Email ID")
                {
                    ApplicationArea = All;
                    Editable = FatherEmailID;
                }
                field("Mothers Name"; Rec."Mothers Name")
                {
                    ApplicationArea = All;
                    Editable = MothersName;
                }

                field("Mother Contact Number"; Rec."Mother Contact Number")
                {
                    ApplicationArea = All;
                    Editable = MotherContactNumber;
                }
                field("Mother Email ID"; Rec."Mother Email ID")
                {
                    ApplicationArea = All;
                    Editable = MotherEmailID;
                }
                field("Guardian Name"; Rec."Guardian Name")
                {
                    ApplicationArea = All;
                    Editable = GuardianName;
                }
                // field("Guardian Occupation"; Rec."Guardian Occupation")
                // {
                //     Visible = false;
                //     ApplicationArea = All;
                // }
                field("Guardian Contact Number"; Rec."Guardian Contact Number")
                {
                    ApplicationArea = All;
                    Editable = GuardianContactNumber;
                }
                field("Guardian Email ID"; Rec."Guardian Email ID")
                {
                    ApplicationArea = All;
                    Editable = GuardianEmailID;
                }
            }
            group("Communication Details")
            {
                Caption = 'Communication Details';
                Editable = true;

                field(Addressee; Rec.Addressee)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address1';
                    MultiLine = true;
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address2';
                    MultiLine = true;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Address3';
                    MultiLine = true;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Country';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Permanent Post Code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent City';
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                    Caption = 'Permanent State';
                }
                //SD-SB-11-JAN-21 +
                field(ShowMap; ShowMapLbl)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ShowCaption = false;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the Student''s address on your preferred map website.';

                    trigger OnDrillDown()
                    begin
                        CurrPage.UPDATE(TRUE);
                        // DisplayMap;
                    end;
                }
                //SD-SB-11-JAN-21 -


                field(Address3; Rec.Address3)
                {
                    ApplicationArea = All;
                    Caption = 'Present Address1';
                    MultiLine = true;
                }
                field(Address4; Rec.Address4)
                {
                    ApplicationArea = All;
                    Caption = 'Present Address2';
                    MultiLine = true;
                }
                field("Address To"; Rec."Address To")
                {
                    ApplicationArea = All;
                    Caption = 'Present Address3';
                    MultiLine = true;
                }
                field("Cor Country Code"; Rec."Cor Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Present Country';
                }
                field("Cor Post Code"; Rec."Cor Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Present Post Code';
                }
                field("Cor City"; Rec."Cor City")
                {
                    ApplicationArea = All;
                    Caption = 'Present City';
                }
                field("Cor State"; Rec."Cor State")
                {
                    ApplicationArea = All;
                    Caption = 'Present State';
                }

                field("Same As Permanent Address"; Rec."Same As Permanent Address")
                {
                    ApplicationArea = All;
                    Caption = 'Same As Permanent Address';
                }
                field("Communication Address"; Rec."Communication Address")
                {
                    ApplicationArea = All;
                    Caption = 'Communication Address';
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                    Caption = 'Student Email ID';
                    // Editable = false;

                }
                field("Alternate Email Address"; Rec."Alternate Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Alternate Email Address';
                    ShowMandatory = true;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                    Caption = 'Earlier Mobile Number';
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                    Caption = 'Present Mobile Number';
                    ShowMandatory = true;
                }
                // field(Skype; Rec.Skype)
                // {
                //     ApplicationArea = All;
                // }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = all;
                }
                Field("Nationality Description"; Rec."Nationality Description")
                {
                    ApplicationArea = All;

                }
                // field(Ethnicity; Rec.Ethnicity)
                // {
                //     ApplicationArea = all;
                // }
                Group("Citizenship Details")
                {
                    field("Eligible Non Citizen"; Rec."Eligible Non Citizen")
                    {
                        ApplicationArea = All;
                    }
                    field("US Citizen"; Rec."US Citizen")
                    {
                        ApplicationArea = All;
                    }
                    field("Indian Citizen"; Rec."Indian Citizen")
                    {
                        ApplicationArea = All;
                    }
                    field("Antigua Citizen"; Rec."Antigua Citizen")
                    {
                        ApplicationArea = All;
                    }
                }

            }
            group("Emergency Contact Information")
            {
                field("Emergency Contact First Name"; Rec."Emergency Contact First Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Name';
                }
                field("Emergency Contact Last Name"; Rec."Emergency Contact Last Name")
                {
                    ApplicationArea = All;
                    Caption = 'Last Name';
                }
                field("Emergency Contact E-Mail"; Rec."Emergency Contact E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                }
                field("Emergency Contact RelationShip"; Rec."Emergency Contact RelationShip")
                {
                    ApplicationArea = All;
                    Caption = 'Relationship';
                }
                field("Emergency Contact Phone No."; Rec."Emergency Contact Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }
                // field("Emergency Contact Phone No. 2"; Rec."Emergency Contact Phone No. 2")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Phone No. 2';
                // }
                field("Emergency Contact Address"; Rec."Emergency Contact Address")
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field("Emergency Contact City"; Rec."Emergency Contact City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field("Emergency Contact State"; Rec."Emergency Contact State")
                {
                    ApplicationArea = All;
                    Caption = 'State';
                }
                field("Emergency Contact Country Code"; Rec."Emergency Contact Country Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country Code';
                }
                field("Emergency Contact Postal Code"; Rec."Emergency Contact Postal Code")
                {
                    ApplicationArea = All;
                    Caption = 'Postal Code';
                }

            }
            group("Local Emergency Contact Information")
            {
                field("Local Emergency First Name"; Rec."Local Emergency First Name")
                {
                    ApplicationArea = All;
                    Caption = 'First Name';
                }
                field("Local Emergency Last Name"; Rec."Local Emergency Last Name")
                {
                    ApplicationArea = All;
                    Caption = 'Last Name';
                }
                field("Local Emergency Phone No."; Rec."Local Emergency Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }
                field("Local Emergency Street Address"; Rec."Local Emergency Street Address")
                {
                    ApplicationArea = All;
                    Caption = 'Street Address';
                }
                field("Local Emergency City"; Rec."Local Emergency City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
            //SD-SN-03-Dec-2020 +
            group("Resident Address (Antigua)")
            {
                //CS_SG 20230523 FALL 2023 OLR Changes
                field("CitizenAntiguaBarbuda"; Rec.CitizenAntiguaBarbuda)
                {
                    ApplicationArea = All;
                    Caption = 'Are you a citizen of Antigua & Barbuda and reside in Antigua? ';
                }
                //CS_SG 20230523 FALL 2023 OLR Changes
                field("Resident Address"; Rec."Resident Address")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                }
                field("Resident City"; Rec."Resident City")
                {
                    ApplicationArea = all;
                }
                field("Resident State"; Rec."Resident State")
                {
                    ApplicationArea = all;
                }
                field("Resident Country"; Rec."Resident Country")
                {
                    ApplicationArea = all;
                }
                field("Resident Zip Code"; Rec."Resident Zip Code")
                {
                    ApplicationArea = all;
                }

            }
            //SD-SN-03-Dec-2020 -
            group("Passport Details")
            {
                Visible = EEDChairCanView;
                field("Name on Passport"; Rec."Name on Passport")
                {
                    ApplicationArea = all;
                }
                field("Pass Port No."; Rec."Pass Port No.")
                {
                    ApplicationArea = all;
                    Caption = 'Passport No.';
                }
                field("Pass Port Issued By"; Rec."Pass Port Issued By")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Issued By';
                }
                field("Pass Port Issued Date"; Rec."Pass Port Issued Date")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Issued Date';
                }

                field("Pass Port Expiry Date"; Rec."Pass Port Expiry Date")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Expiry Date';
                }


                field("Permanent U.S. Resident"; Rec."Permanent U.S. Resident")
                {
                    ApplicationArea = all;
                }
                field("Visa No."; Rec."Visa No.")
                {
                    ApplicationArea = All;
                }
                field("Visa Issued Date"; Rec."Visa Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Visa Expiry Date"; Rec."Visa Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Visa Extension Date"; Rec."Visa Extension Date")
                {
                    ApplicationArea = all;
                }
                field("Immigration Issuance Date"; Rec."Immigration Issuance Date")
                {
                    ApplicationArea = All;
                }
                field("Immigration Expiration Date"; Rec."Immigration Expiration Date")
                {
                    ApplicationArea = All;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = all;
                }
                Field("Flight Number"; Rec."Flight Number")
                {
                    ApplicationArea = all;
                }
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = all;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = all;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = all;
                }

            }
            group("Pre-Admission Details1")
            {
                Caption = 'Pre-Admission Details';
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Other GPA"; Rec."Other GPA")
                {
                    ApplicationArea = all;
                }
                field("Graduate GPA"; Rec."Graduate GPA")
                {
                    ApplicationArea = all;
                }
                field("High School GPA"; Rec."High School GPA")
                {
                    ApplicationArea = all;
                }
                field("Pre-Req GPA"; Rec."Pre-Req GPA")
                {
                    ApplicationArea = all;
                }
                field("Transfer GPA"; Rec."Transfer GPA")
                {
                    ApplicationArea = all;
                }
                field("Person Lead Source"; Rec."Person Lead Source")
                {
                    ApplicationArea = All;
                }
                field("Primary Lead Source"; Rec."Primary Lead Source")
                {
                    ApplicationArea = All;
                }
                field("Other Lead Source"; Rec."Other Lead Source")
                {
                    ApplicationArea = All;
                }
                field("Account Person Type"; Rec."Account Person Type")
                {
                    ApplicationArea = All;
                }
                field("School Level"; Rec."School Level")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("Application Sub-type"; Rec."Application Sub-type")
                {
                    ApplicationArea = All;
                }
                field("Sub-Stage"; Rec."Sub-Stage")
                {
                    ApplicationArea = All;
                }
                field("Seat Deposit Paid"; Rec."Seat Deposit Paid")
                {
                    ApplicationArea = All;
                }
                field("Deposit Paid Date"; Rec."Deposit Paid Date")
                {
                    ApplicationArea = All;
                }
                field("Deposit Waived"; Rec."Deposit Waived")
                {
                    ApplicationArea = All;
                }
                field("Housing Deposit Waived"; Rec."Housing Deposit Waived")
                {
                    ApplicationArea = All;
                }
                field("Housing Deposit Date"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;
                }
                field(Housings; Rec.Housing)
                {
                    ApplicationArea = All;
                }
                field("Student Accepted Date"; Rec."Student Accepted Date")
                {
                    ApplicationArea = All;
                }
                field("OLR Email Sent"; Rec."OLR Email Sent")
                {
                    ApplicationArea = All;
                }
            }
            group("Academics Information")
            {
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                    Caption = 'Program';
                    ShowMandatory = true;
                }
                Field("Semester Decision"; Rec."Semester Decision")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Estimated Graduation Date"; Rec."Estimated Graduation Date")
                {
                    ApplicationArea = All;
                }
                field("Date Cleared"; Rec."Date Cleared")
                {
                    ApplicationArea = All;
                }
                field("Date Awarded"; Rec."Date Awarded")
                {
                    ApplicationArea = All;
                }
                Field("Island Departure Date"; Rec."Island Departure Date")
                {
                    ApplicationArea = All;
                }
                field("Graduation Date"; Rec."Graduation Date")
                {
                    ApplicationArea = All;
                }
                field("Returning Student"; Rec."Returning Student")
                {
                    ApplicationArea = All;
                }
                field("Remaining Academic SAP"; Rec."Remaining Academic SAP")
                {
                    ApplicationArea = All;
                    Caption = 'Academic SAP';
                }
                field("Media Release Sign-off"; Rec."Media Release Sign-off")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                    Caption = 'OLR Completed';
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student On-Ground Group"; Rec."Student Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                // field("Student QRCode"; Rec."Student QRCode")
                // {
                //     ApplicationArea = All;
                // }

                field("On Ground Check-In On"; Rec."On Ground Check-In On")
                {
                    ApplicationArea = All;
                }
                field("On Ground Check-In Complete By"; Rec."On Ground Check-In Complete By")
                {
                    ApplicationArea = All;
                }
                field("On Ground Check-In Complete On"; Rec."On Ground Check-In Complete On")
                {
                    ApplicationArea = All;
                }
                field("On Ground Check-In By"; Rec."On Ground Check-In By")
                {
                    ApplicationArea = All;
                }


                field("Current Semester Start Date"; Rec."Current Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Semester End Date"; Rec."Current Semester End Date")
                {
                    ApplicationArea = All;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                Field("Dismissal Date"; Rec."Dismissal Date")
                {
                    ApplicationArea = All;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }
                field(LDA; Rec.LDA)
                {
                    ApplicationArea = ALL;
                    Caption = 'Last Date Of Attendance';
                    //Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                    Caption = 'Assigned Assistant Registrar';
                }

                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Re-Entry Date"; Rec."Re-Entry Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                Field("Basic Science GPA"; Rec."Basic Science GPA")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                Field("Clinical GPA"; Rec."Clinical GPA")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                Field("Overall GPA"; Rec."Overall GPA")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("GPA Credits"; Rec."GPA Credits")
                {
                    ApplicationArea = All;
                    Editable = False;
                }


                field(StudentFERPA; Rec.StudentFERPA)
                {
                    ApplicationArea = All;
                }
                Field("FERPA Release"; Rec."FERPA Release")
                {
                    ApplicationArea = All;
                }
                Field("Ferpa Release Date"; Rec."Ferpa Release Date")
                {
                    ApplicationArea = All;
                }
                field("Clinical Curriculum"; Rec."Clinical Curriculum")
                {
                    ApplicationArea = All;
                }
                field(CountryOfCitizenship; Rec.CountryOfCitizenship)
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Assistant Registrar"; Rec."Assistant Registrar")
                {
                    ToolTip = 'Specifies the value of the Assistant Registrar field.';
                    ApplicationArea = All;
                }


                /////GAURAV//12.12.22//////


            }
            group("Examination Information")//GAURAV//
            {
                field("CBSE Attempts"; Rec."CBSE Attempts")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                Field("CBSE Date"; Rec."CBSE Date")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field(CompShelfBest; Rec.CompShelfBest)
                {
                    ApplicationArea = All;

                }

                field(ClnUsmleStep1EverApplied; Rec.ClnUsmleStep1EverApplied)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Ever Applied';
                }
                field(UsmleID; Rec.UsmleID)
                {
                    ApplicationArea = All;
                }
                field(UsmleRefCode; Rec.UsmleRefCode)
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field(UsmleCertDate; Rec.UsmleCertDate)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Certification Date';
                }
                field("Step I Test Window"; Rec."Step I Test Window")
                {
                    ApplicationArea = All;
                }
                field(ClnUsmleStep1MaxAttempt; Rec.ClnUsmleStep1MaxAttempt)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Max Attempt';
                }
                field(ClnUsmleStep1Date; Rec.ClnUsmleStep1Date)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Max Date';
                }
                field(ClnUsmleStep1Best; Rec.ClnUsmleStep1Best)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Max Best';
                }
                field(ClnUsmleStep1Passed; Rec.ClnUsmleStep1Passed)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 1 Passed';
                }
                field("CCSSE PSY Score"; Rec."CCSSE PSY Score")
                {
                    ApplicationArea = All;

                }
                field("CCSSE FM Score"; Rec."CCSSE FM Score")
                {
                    ApplicationArea = All;


                }
                Field("CCSSE PEDS Score"; Rec."CCSSE PEDS Score")
                {
                    ApplicationArea = All;

                }
                field("CCSSE IM Score"; Rec."CCSSE IM Score")
                {
                    ApplicationArea = All;

                }
                Field("CCSSE OB Score"; Rec."CCSSE OB Score")
                {
                    ApplicationArea = All;
                }
                field("CCSSE SUR Score"; Rec."CCSSE SUR Score")
                {
                    ApplicationArea = All;
                }
                field("CCSE Date"; Rec."CCSE Date")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("CCSE Attempts"; Rec."CCSE Attempts")
                {
                    ApplicationArea = All;
                }
                Field("CCSE Score"; Rec."CCSE Score")
                {
                    ApplicationArea = All;
                    //Visible = false;
                }

                field("CCSSE Date"; Rec."CCSSE Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(ClnUsmleCertificationDate; Rec.ClnUsmleCertificationDate)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step 2 CK certification Date';
                }
                field("Step II (CK) Test Window"; Rec."Step II (CK) Test Window")
                {
                    ApplicationArea = All;
                }
                field(ClnUsmleCKMaxAttempt; Rec.ClnUsmleCKMaxAttempt)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CK Max Attempt';
                }
                field(ClnUsmleCKDate; Rec.ClnUsmleCKDate)
                {
                    ApplicationArea = All;
                    Caption = ' USMLE Step II CK Exam Date';
                }
                field(ClnUsmleCKBest; Rec.ClnUsmleCKBest)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE Step CK Score';
                }
                field(ClnUsmleCKPassed; Rec.ClnUsmleCKPassed)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CK Passed';
                }
                field("Step II (CS) Test Window"; Rec."Step II (CS) Test Window")
                {
                    ApplicationArea = All;
                }
                field(ClnUsmleCSMaxAttempt; Rec.ClnUsmleCSMaxAttempt)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CS Max Attempt';
                    // Visible = false;
                }
                field(ClnUsmleCSDate; Rec.ClnUsmleCSDate)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CS Date';
                    // Visible = false;
                }
                field(ClnUsmleCSBest; Rec.ClnUsmleCSBest)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CS Score';
                    // Visible = false;
                }
                field(ClnUsmleCSPassed; Rec.ClnUsmleCSPassed)
                {
                    ApplicationArea = All;
                    Caption = 'USMLE CS Passed';
                    // Visible = false;
                }
                field(UsmleCertTranscriptDate; Rec.UsmleCertTranscriptDate)
                {
                    ApplicationArea = All;
                }
                field(UsmleTranscriptRcvdDate; Rec.UsmleTranscriptRcvdDate)
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field(EcfmgCertDate; Rec.EcfmgCertDate)
                {
                    ApplicationArea = All;
                }

                field(CompShelfDate; Rec.CompShelfDate)//GAURAV//
                {
                    ApplicationArea = All;
                    Caption = 'CBSE Date';
                    Visible = false;
                }
                field("CCSSE Attempts"; Rec."CCSSE Attempts")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(CompShelfAttempts; Rec.CompShelfAttempts)
                {
                    ApplicationArea = All;
                    Caption = 'CBSE Attempts';
                    Visible = false;
                }
                field(ExpectedGradeDate; Rec.ExpectedGradeDate)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(ManualEGD; Rec.ManualEGD)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Unique Medical School ID"; Rec."Unique Medical School ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(StudentDocsUpdated; Rec.StudentDocsUpdated)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group("Housing Information")
            {
                Visible = EEDChairCanView;
                field("Housing Group"; HousingGroupText)
                {
                    Caption = 'Housing Group';
                    ApplicationArea = all;

                }
                field("Housing ID"; HousingID)
                {
                    Caption = 'Housing ID';
                    ApplicationArea = all;

                }
                field("Room Category Code"; ApartmentCategoryCode)
                {
                    Caption = 'Apartment Category Code';
                    ApplicationArea = all;

                }
                field("Room No."; ApartmentNo)
                {
                    Caption = 'Apartment No.';
                    ApplicationArea = all;

                }
                field("Bed No."; RoomNo)
                {
                    Caption = 'Room No.';
                    ApplicationArea = all;


                }
                field("Housing Type"; Rec."Housing Type")
                {
                    Caption = 'Housing Type';
                    ApplicationArea = all;
                }
                field("Temporary Apartment No."; Rec."Temporary Apartment No.")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("Temporary Housing Name"; Rec."Temporary Housing Name")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("Temporary Room No."; Rec."Temporary Room No.")
                {
                    ApplicationArea = All;
                    Editable = True;
                }
                field("Airport Check-in"; Rec."Airport Check-in")//GAURAV//25//01//23//START
                {
                    ApplicationArea = All;
                }
                field("Airport Check-in date"; Rec."Airport Check-in date")
                {
                    ApplicationArea = All;
                }
                field("Housing Check-in"; Rec."Housing Check-in")
                {
                    ApplicationArea = All;
                }
                field("Housing Check-in date"; Rec."Housing Check-in date")//GAURAV//25//01//23//END
                {
                    ApplicationArea = All;
                }

            }
            group("Bursar Information")
            {
                Caption = 'Bursar Information';
                Editable = true;

                field("Payment Plan Applied"; Rec."Payment Plan Applied")
                {
                    ApplicationArea = all;
                    Editable = false;
                    trigger OnValidate()
                    begin
                        Boolean_gBool := false;
                        If Rec."Payment Plan Applied" then
                            Boolean_gBool := true;
                    end;
                }
                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = all;
                    Visible = FinancialAid_GBoo;
                    Editable = false;
                }
                Field("Applied For Scholarship"; Rec."Applied For Scholarship")
                {
                    ApplicationArea = All;
                }
                Field("Self-Pay Applied"; Rec."Self-Pay Applied")
                {
                    ApplicationArea = All;

                }
                Field("VA Benefit"; Rec."VA Benefit")
                {
                    ApplicationArea = All;
                }
                Field("MOU Agreement"; Rec."MOU Agreement")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = all;
                    Editable = Boolean_gBool;
                }

                field("Self Payment Applied"; Rec."Self Payment Applied")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                Field("Student Return to Lender"; Rec."Student Return to Lender")
                {
                    ApplicationArea = all;
                }
                field("Fee Generated Amount"; Rec."Fee Generated Amount")
                {
                    ApplicationArea = all;
                    Lookup = true;
                    DrillDown = true;
                    Visible = Balance;
                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Semester, Rec.Semester);
                        CustomerLedEntries.SetRange("Document Type", CustomerLedEntries."Document Type"::Invoice);
                        CustomerLedEntries.SetFilter("Enrollment No.", Rec."Enrollment No.");
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }
                field("Scholarship Source"; Rec."Scholarship Source")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 1"; Rec."Grant Code 1")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 2"; Rec."Grant Code 2")
                {
                    ApplicationArea = All;
                }
                field("Grant Code 3"; Rec."Grant Code 3")
                {
                    ApplicationArea = All;
                }
                field("Sibling/Spouse No."; Rec."Sibling/Spouse No.")
                {
                    ApplicationArea = All;
                }
                field("Transport Allot"; Rec."Transport Allot")
                {
                    ApplicationArea = All;
                }
                Field("Transport Cell"; Rec."Transport Cell")
                {
                    ApplicationArea = All;
                    Caption = 'Transport Contact Number (Cell)';
                }

                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                    Caption = 'Category';
                    ShowMandatory = true;
                }
                field("Customer Exists"; Rec."Customer Exists")
                {
                    ApplicationArea = All;
                    Visible = Balance;
                }
                field("Tuition Balance"; Rec."Tuition Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Tuition Balance';
                    Visible = Balance;
                    Lookup = true;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;

                }
                field("Grenville Balance"; Rec."Grenville Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Grenville Balance';
                    Visible = Balance;
                    Lookup = true;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9300');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;

                }
                field("AUA Housing Balance"; Rec."AUA Housing Balance")
                {
                    ApplicationArea = All;
                    Caption = 'AUA Housing Balance';
                    Lookup = true;
                    DrillDown = true;
                    Visible = Balance;
                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetRange(Open, true);
                        CustomerLedEntries.SetRange("Enrollment No.", Rec."Enrollment No.");
                        CustomerLedEntries.SetFilter("Global Dimension 1 Code", '%1', Rec."Global Dimension 1 Code");
                        CustomerLedEntries.SetFilter("Global Dimension 2 Code", '%1', '9500');
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;
                }
                field("Current Balance"; Rec."Current Balance")
                {
                    ApplicationArea = All;
                    Caption = 'Current Balance';
                    Lookup = true;
                    DrillDown = true;
                    Visible = Balance;
                    trigger OnDrillDown()
                    var
                        CustomerLedEntries: Record "Cust. Ledger Entry";
                    begin
                        CustomerLedEntries.FilterGroup(0);
                        CustomerLedEntries.reset();
                        CustomerLedEntries.SetRange("Customer No.", Rec."Original Student No.");
                        CustomerLedEntries.SetFilter("Enrollment No.", Rec."Enrollment No.");
                        if CustomerLedEntries.FindFirst() then begin
                            page.Run(25, CustomerLedEntries);
                            CustomerLedEntries.FilterGroup(2);
                        end;
                    end;

                }
                field(ClnWksFailedBilled; Rec.ClnWksFailedBilled)
                {
                    ApplicationArea = All;
                }
                field(ClnBldSem5; Rec.ClnBldSem5)
                {
                    ApplicationArea = All;
                }
                field(ClnBldSem6; Rec.ClnBldSem6)
                {
                    ApplicationArea = All;
                }
                field(ClnBldSem7; Rec.ClnBldSem7)
                {
                    ApplicationArea = All;
                }
                field(ClnBldSem8; Rec.ClnBldSem8)
                {
                    ApplicationArea = All;
                }
                field(ClnBldSemXtra; Rec.ClnBldSemXtra)
                {
                    ApplicationArea = All;
                }
                field(StudentInsuranceCode; Rec.StudentInsuranceCode)
                {
                    ApplicationArea = All;
                }
                field(Transport; Rec.Transport)
                {
                    ApplicationArea = All;
                }
                field(Selfpay; Rec.Selfpay)
                {
                    ApplicationArea = All;
                }


            }
            group("Insurance Details")
            {
                //SD-SN-12-Dec-2020 +
                field("Apply For Insurance"; Rec."Apply For Insurance")
                {
                    ApplicationArea = All;
                }
                //SD-SN-12-Dec-2020 - 
                field("Insurance Carrier"; Rec."Insurance Carrier")
                {
                    ApplicationArea = All;
                }
                field("Policy Number / Group Number"; Rec."Policy Number / Group Number")
                {
                    ApplicationArea = All;
                }
                field("Insurance Valid From"; Rec."Insurance Valid From")
                {
                    ApplicationArea = All;
                }
                field("Insurance Valid To"; Rec."Insurance Valid To")
                {
                    ApplicationArea = All;
                }

            }
            group("Bank Details")
            {
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Account Holder Name"; Rec."Account Holder Name")
                {
                    ApplicationArea = All;
                }
                field("Bank A/C Number"; Rec."Bank A/C Number")
                {
                    ApplicationArea = All;
                }
                field("IBAN No"; Rec."IBAN No")
                {
                    ApplicationArea = All;
                }
                field("SWIFT No"; Rec."SWIFT No")
                {
                    ApplicationArea = All;
                }
            }
            group("Financial Aid Information")
            {

                Visible = FinancialAid_GBoo;
                field("Financial Aid Approval"; Rec."Financial Aid Approved")
                {
                    ApplicationArea = all;
                    Visible = FinancialAid_GBoo;
                    Editable = false;
                }
                field("Type of FA Roster"; Rec."Type of FA Roster")
                {
                    ApplicationArea = All;
                }
                field("FAFSA Received"; Rec."FAFSA Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("FAFSA Applied"; Rec."FAFSA Applied")
                {
                    ApplicationArea = All;
                }
                field("FSA ID"; Rec."FSA ID")
                {
                    ApplicationArea = All;
                }
                field("FAFSA Type"; Rec."FAFSA Type")
                {
                    ApplicationArea = All;
                }
                field("T4 Authorization"; Rec."T4 Authorization")
                {
                    ApplicationArea = all;

                }
                field("Financial Aid Status"; Rec."Financial Aid Status")
                {
                    ApplicationArea = all;
                }
                field("SAP Semester"; Rec."SAP Semester")
                {
                    ToolTip = 'Specifies the value of the SAP Semester field.';
                    ApplicationArea = All;
                }
                field("FA SAP Status"; Rec."FA SAP Status")
                {
                    ApplicationArea = all;
                }
                Field("Student SFP Initiation"; Rec."Student SFP Initiation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Student SFP Update"; Rec."Student SFP Update")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("SAFI Syncs"; Rec."SAFI Sync")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("SFP-LOA"; Rec."SFP-LOA")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Current FA Academic Year"; Rec."Current FA Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Students FA Academic Years"; Rec."Students FA Academic Years")
                {
                    ApplicationArea = all;
                }
                field("Current Loan Period Start Date"; Rec."Current Loan Period Start Date")
                {
                    ApplicationArea = all;
                }
                field("Current Loan Period End Date"; Rec."Current Loan Period End Date")
                {
                    ApplicationArea = all;
                }
                field("5 FA Start Date"; Rec."5 FA Start Date")
                {
                    ApplicationArea = all;
                }
                field("5 FA End Date"; Rec."5 FA End Date")
                {
                    ApplicationArea = all;
                }
                field("6 FA Start Date"; Rec."6 FA Start Date")
                {
                    ApplicationArea = all;
                }
                field("6 FA End Date"; Rec."6 FA End Date")
                {
                    ApplicationArea = all;
                }
                field("7 FA Start Date"; Rec."7 FA Start Date")
                {
                    ApplicationArea = all;
                }
                field("7 FA End Date"; Rec."7 FA End Date")
                {
                    ApplicationArea = all;
                }
                field("8 FA Start Date"; Rec."8 FA Start Date")
                {
                    ApplicationArea = all;
                }
                field("8 FA End Date"; Rec."8 FA End Date")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    var
                        ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    begin
                        ClinicalBaseAppSubscribe.SemesterProgression(Rec, true);
                    end;

                }
                field("FA Semester"; Rec."FA Semester")
                {
                    ToolTip = 'Specifies the value of the FA Semester field.';
                    ApplicationArea = All;
                }

                field("Xtra Start Date"; Rec."Xtra Start Date")
                {
                    ApplicationArea = all;
                }
                field("Xtra End Date"; Rec."Xtra End Date")
                {
                    ApplicationArea = all;
                }
                field("FA SAP Sub Status"; Rec."FA SAP Sub Status")
                {
                    ApplicationArea = all;
                    visible = false;
                }
                field("Failed SAP Reason"; Rec."Failed SAP Reason")
                {
                    ApplicationArea = all;
                }
                field("Financial Aid Recipient"; Rec."Financial Aid Recipient")
                {
                    ApplicationArea = all;
                }
                field("FA SAP Status Action"; Rec."FA SAP Status Action")
                {
                    ApplicationArea = all;
                    visible = false;
                }
                field("FA SAP Outcome"; Rec."FA SAP Outcome")
                {
                    ApplicationArea = all;
                    visible = false;
                }
                field("FA Semester Affected"; Rec."FA Semester Affected")
                {
                    ApplicationArea = all;
                }
                field(StudentFinancialAid; Rec.StudentFinancialAid)
                {
                    ApplicationArea = All;
                }

                field(ClnFinProc5; Rec.ClnFinProc5)
                {
                    ApplicationArea = All;
                }
                field(ClnFinProc6; Rec.ClnFinProc6)
                {
                    ApplicationArea = All;
                }
                field(ClnFinProc7; Rec.ClnFinProc7)
                {
                    ApplicationArea = All;
                }
                field(ClnFinProc8; Rec.ClnFinProc8)
                {
                    ApplicationArea = All;
                }
            }
            group("Clinical")
            {
                Visible = False;
                field("Document Specialist"; Rec."Document Specialist")
                {
                    ApplicationArea = all;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    ApplicationArea = all;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    ApplicationArea = all;
                }

                field(ClnDocsComplete; Rec.ClnDocsComplete)
                {
                    ApplicationArea = All;
                }
                field(ClnCurrentlyRotating; Rec.ClnCurrentlyRotating)
                {
                    ApplicationArea = All;
                }
                field(Cln1stRotationStarted; Rec.Cln1stRotationStarted)
                {
                    ApplicationArea = All;
                }
                field(ClnLastRotationEnd; Rec.ClnLastRotationEnd)
                {
                    ApplicationArea = All;
                }
                field(ClnNextRotationStart; Rec.ClnNextRotationStart)
                {
                    ApplicationArea = All;
                }
                field(ClnNextSemStart; Rec.ClnNextSemStart)
                {
                    ApplicationArea = All;
                }
                field(ClnSemStart5; Rec.ClnSemStart5)
                {
                    ApplicationArea = All;
                }
                field(ClnSemStart6; Rec.ClnSemStart6)
                {
                    ApplicationArea = All;
                }
                field(ClnSemStart7; Rec.ClnSemStart7)
                {
                    ApplicationArea = All;
                }
                field(ClnSemStart8; Rec.ClnSemStart8)
                {
                    ApplicationArea = All;
                }
                field(ClnWksOnRecord; Rec.ClnWksOnRecord)
                {
                    ApplicationArea = All;
                }
                field(ClnWksTransferred; Rec.ClnWksTransferred)
                {
                    ApplicationArea = All;
                }
                field(ClnWksScheduledHere; Rec.ClnWksScheduledHere)
                {
                    ApplicationArea = All;
                }
                field(ClnWksSatisfiedHere; Rec.ClnWksSatisfiedHere)
                {
                    ApplicationArea = All;
                }
                field(ClnWksSatisfiedOptimistic; Rec.ClnWksSatisfiedOptimistic)
                {
                    ApplicationArea = All;
                }
                field(ClnWksSatisfiedPessimistic; Rec.ClnWksSatisfiedPessimistic)
                {
                    ApplicationArea = All;
                }
                field(ClnWksSatisfiedTotal; Rec.ClnWksSatisfiedTotal)
                {
                    ApplicationArea = All;
                }
                field(ClnWksFailed; Rec.ClnWksFailed)
                {
                    ApplicationArea = All;
                }
                field(ClnDog5; Rec.ClnDog5)
                {
                    ApplicationArea = All;
                }
                field(ClnDog6; Rec.ClnDog6)
                {
                    ApplicationArea = All;
                }
                field(ClnDog7; Rec.ClnDog7)
                {
                    ApplicationArea = All;
                }
                field(ClnDog8; Rec.ClnDog8)
                {
                    ApplicationArea = All;
                }
                field(ClnDogToDate; Rec.ClnDogToDate)
                {
                    ApplicationArea = All;
                }
                field(ClnDogSched; Rec.ClnDogSched)
                {
                    ApplicationArea = All;
                }
                field(ClnDogCurrSem; Rec.ClnDogCurrSem)
                {
                    ApplicationArea = All;
                }
                field(ClnDogCurrent; Rec.ClnDogCurrent)
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Proposed Start Date"; Rec."FM1/IM1 Proposed Start Date")
                {
                    ApplicationArea = All;
                }
                field("FM1/IM1 Document Due Date"; Rec."FM1/IM1 Document Due Date")
                {
                    ApplicationArea = All;
                }
                field("Rotation Count"; Rec."Rotation Count")
                {
                    ApplicationArea = All;
                }
                field(Cln5thSemEnded; Rec.Cln5thSemEnded)
                {
                    ApplicationArea = All;
                }
                field(Cln6thSemEnded; Rec.Cln6thSemEnded)
                {
                    ApplicationArea = All;
                }
                field(Cln7thSemEnded; Rec.Cln7thSemEnded)
                {
                    ApplicationArea = All;
                }
                field(Cln8thSemEnded; Rec.Cln8thSemEnded)
                {
                    ApplicationArea = all;
                }
            }
            group("Residency Details")
            {
                Visible = False;
                field("Residency Hospital 1"; Rec."Residency Hospital 1")
                {
                    ApplicationArea = all;
                }
                field("Residency Hospital 2"; Rec."Residency Hospital 2")
                {
                    ApplicationArea = all;
                }
                field("Residency Status"; Rec."Residency Status")
                {
                    ApplicationArea = all;
                }
                field("Residency Specialty 1"; Rec."Residency Specialty 1")
                {
                    ApplicationArea = all;
                }
                field("Residency Specialty 2"; Rec."Residency Specialty 2")
                {
                    ApplicationArea = all;
                }
                field("Residency Year"; Rec."Residency Year")
                {
                    ApplicationArea = all;
                }
                field("Residency State"; Rec."Residency State")
                {
                    ApplicationArea = all;
                }
                field("Residency City"; Rec."Residency City")
                {
                    ApplicationArea = all;
                }

            }
            group("Semester GPA")
            {
                Caption = 'Semester GPA';
                Editable = true;
                Visible = false;
                field("Semester I Credit Earned"; Rec."Semester I Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester II Credit Earned"; Rec."Semester II Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester III Credit Earned"; Rec."Semester III Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester IV Credit Earned"; Rec."Semester IV Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester V Credit Earned"; Rec."Semester V Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester VI Credit Earned"; Rec."Semester VI Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester VII Credit Earned"; Rec."Semester VII Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester VIII Credit Earned"; Rec."Semester VIII Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Semester I GPA"; Rec."Semester I GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester II GPA"; Rec."Semester II GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester III GPA"; Rec."Semester III GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester IV GPA"; Rec."Semester IV GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester V GPA"; Rec."Semester V GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester VI GPA"; Rec."Semester VI GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester VII GPA"; Rec."Semester VII GPA")
                {
                    ApplicationArea = All;
                }
                field("Semester VIII GPA"; Rec."Semester VIII GPA")
                {
                    ApplicationArea = All;
                }
                field("Net Semester CGPA"; Rec."Net Semester CGPA")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
            }
            group("Year GPA")
            {

                Caption = 'Year GPA';
                Editable = true;
                Visible = false;
                field("Year 1 Credit Earned"; Rec."Year 1 Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Year 2 Credit Earned"; Rec."Year 2 Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Year 3 Credit Earned"; Rec."Year 3 Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Year 4 Credit Earned"; Rec."Year 4 Credit Earned")
                {
                    ApplicationArea = All;
                }
                field("Year 1 GPA"; Rec."Year 1 GPA")
                {
                    ApplicationArea = All;
                }
                field("Year 2 GPA"; Rec."Year 2 GPA")
                {
                    ApplicationArea = All;
                }
                field("Year 3 GPA"; Rec."Year 3 GPA")
                {
                    ApplicationArea = All;
                }
                field("Year 4 GPA"; Rec."Year 4 GPA")
                {
                    ApplicationArea = All;
                }
                field("Net Year CGPA"; Rec."Net Year CGPA")
                {
                    ApplicationArea = All;
                }
            }
            group("Legacy Fields")
            {
                field("Local Emergency Email Address"; Rec."Local Emergency Email Address")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Lead Date"; Rec."Lead Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Lead Type Code"; Rec."Lead Type Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Original Start Date"; Rec."Original Start Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Original Exp. Start Date"; Rec."Original Exp. Start Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }


                field(SAPStatus; Rec.SAPStatus)
                {
                    ApplicationArea = All;
                }
                field(SAPDate; Rec.SAPDate)
                {
                    ApplicationArea = All;
                }
                field("Application Received Date"; Rec."Application Received Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Mid Date"; Rec."Mid Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                // field(LDA; Rec.LDA)
                // {
                //     ApplicationArea = All;
                //     Visible=false;
                //     Editable = False;
                // }
                field("Status Date"; Rec."Status Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = false;
                }
                field("Grade Level Description"; Rec."Grade Level Description")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Credits Attempt"; Rec."Credits Attempt")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Program Version ID"; Rec."Program Version ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(SAP; Rec.SAP)
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = false;
                }
                field("Billing Method ID"; Rec."Billing Method ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Address Type"; Rec."Address Type")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("External SIS ID"; Rec."External SIS ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("KMC ID"; Rec."KMC ID")
                {
                    ApplicationArea = All;

                }
                field(StudentUSMLEConsentRelease; Rec.StudentUSMLEConsentRelease)
                {
                    ApplicationArea = All;
                }


                field(StudentConfirmedRegistration; Rec.StudentConfirmedRegistration)
                {
                    ApplicationArea = All;
                }
                field(StudentMediaRelease; Rec.StudentMediaRelease)
                {
                    ApplicationArea = All;
                }

                field(QBStudentID; Rec.QBStudentID)
                {
                    ApplicationArea = All;
                }
                field(TSStudentEID; Rec.TSStudentEID)
                {
                    ApplicationArea = All;
                }
                field(StudentAltKey; Rec.StudentAltKey)
                {
                    ApplicationArea = All;
                }
                field(AamcID; Rec.AamcID)
                {
                    ApplicationArea = All;
                }
                field("Remote Learning Choice"; Rec."Remote Learning Choice")
                {
                    ApplicationArea = All;
                }
                field("Block"; Rec."Block")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Vet"; Rec."Vet")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Raw Last Name"; Rec."Raw Last Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Raw First Name"; Rec."Raw First Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Phone Extension"; Rec."Phone Extension")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Transfer In Date"; Rec."Transfer In Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Date Placed"; Rec."Date Placed")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Suffix Code"; Rec."Suffix Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("ECFMG ID"; Rec."ECFMG ID")
                {
                    ApplicationArea = All;
                    Caption = 'ECFMG ID';
                    Visible = False;
                }
            }
        }
        area(factboxes)
        {
            part("Student Picture"; "Student Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Hold FactBox"; "Hold FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");
            }
            // part("Group FactBox"; "Group FactBox")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Student No." = FIELD("No.");
            // }

            // part(EnrollmentwiseStudentFactbox; EnrollmentwiseStudentFactbox)
            // {
            //     ApplicationArea = all;
            //     subpagelink = "Original Student No." = field("Original Student No.");
            // }
            // part("Student QRCode1"; "Student QRCode")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "No." = FIELD("No.");
            // }
            // part("Residency Fact Box"; "Residency Fact Box")
            // {
            //     ApplicationArea = All;
            //     SubPageLink = "Student No." = FIELD("No.");
            // }


        }
    }

    actions
    {
        area(Processing)
        {

            //360 start
            group("360 Degree View")
            {
                Image = ViewDetails;
                Caption = '360 Degree View';

                group(Admission)
                {
                    Visible = AdmissionGroup;
                    action("Create Next Enrollment")
                    {
                        Caption = 'Create Next Enrollment';
                        Image = NewCustomer;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            Stud: Record "Student Master-CS";
                            // StudBufferList: Page "Student Buffer List";
                            ExtraChar: Code[1];
                            InstCode: Code[20];
                            StudCount: Integer;
                            Selection: Integer;
                            InstituteCodeQuest: Label '&AUA,A&ICASA';
                            DefaultOption: Integer;
                        begin
                            if confirm('Do you want to create New Enrollment for the Student No. %1', false, Rec."Original Student No.") then begin
                                Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                                if Selection > 0 then begin
                                    if Selection = 1 then
                                        InstCode := '9000'
                                    else
                                        if Selection = 2 then
                                            InstCode := '9100';
                                    Stud.Reset();
                                    Stud.SetRange("Original Student No.", Rec."Original Student No.");
                                    if Stud.FindFirst() then
                                        if Stud."Enrollment No." = '' then
                                            Error('You need to assign Program Code for the Student No. %1, Enrollment No. %2', Stud."No.", Stud."Enrollment No.");
                                    Stud.Reset();
                                    Stud.SetRange("Original Student No.", Rec."Original Student No.");
                                    StudCount := Stud.Count();
                                    Stud.Reset();
                                    Stud.Init();
                                    // Stud.Validate("Enrollment Order", StudBufferList.CreateStudentNo("Original Student No.", ExtraChar));
                                    Stud.Validate("No.", (Rec."Original Student No." + ExtraChar));
                                    Stud.validate("Original Student No.", Rec."Original Student No.");
                                    Stud.Validate("Parent Student No.", Rec."Original Student No.");
                                    Stud.Validate("18 Digit ID", Rec."18 Digit ID");
                                    Stud.Validate("Global Dimension 1 Code", InstCode);
                                    Stud.Validate("First Name", Rec."First Name");
                                    Stud.Validate("Last Name", Rec."Last Name");
                                    Stud.Validate(Title, Rec.Title);
                                    Stud.Validate("Middle Name", Rec."Middle Name");
                                    Stud.Validate("Maiden Name", Rec."Maiden Name");
                                    Stud.Validate("Marital Status", Rec."Marital Status");
                                    Stud.Validate("Social Security No.", Rec."Social Security No.");
                                    Stud.Validate("Date of Birth", Rec."Date of Birth");
                                    Stud.Validate(Gender, Rec.Gender);
                                    Stud.Validate("Fathers Name", Rec."Fathers Name");
                                    Stud.Validate("Father Contact Number", Rec."Father Contact Number");
                                    Stud.Validate("Father Email ID", Rec."Father Email ID");
                                    Stud.Validate("Mothers Name", Rec."Mothers Name");
                                    Stud.Validate("Mother Contact Number", Rec."Mother Contact Number");
                                    Stud.Validate("Mother Email ID", Rec."Mother Email ID");
                                    Stud.Validate(Addressee, Rec.Addressee);
                                    Stud.Address1 := Rec.Address1;
                                    Stud.Address2 := Rec.Address2;
                                    Stud."Country Code" := Rec."Country Code";
                                    Stud."Post Code" := Rec."Post Code";
                                    Stud.City := Rec.City;
                                    Stud.State := Rec.State;
                                    Stud.Address3 := Rec.Address3;
                                    Stud.Address4 := Rec.Address4;
                                    Stud."Cor Country Code" := Rec."Cor Country Code";
                                    Stud."Cor Post Code" := Rec."Cor Post Code";
                                    Stud."Cor City" := Rec."Cor City";
                                    Stud."Cor State" := Rec."Cor State";
                                    Stud."Same As Permanent Address" := Rec."Same As Permanent Address";
                                    Stud."Communication Address" := Rec."Communication Address";
                                    Stud."E-Mail Address" := Rec."E-Mail Address";
                                    Stud."Phone Number" := Rec."Phone Number";
                                    Stud."Mobile Number" := Rec."Mobile Number";
                                    Stud.Nationality := Rec.Nationality;
                                    Stud.Citizenship := Rec.Citizenship;
                                    Stud."Alternate Email Address" := Rec."Alternate Email Address";
                                    Stud."Emergency Contact First Name" := Rec."Emergency Contact First Name";
                                    Stud."Emergency Contact Last Name" := Rec."Emergency Contact Last Name";
                                    Stud."Emergency Contact E-Mail" := Rec."Emergency Contact E-Mail";
                                    Stud."Emergency Contact Address" := Rec."Emergency Contact Address";
                                    Stud."Emergency Contact RelationShip" := Rec."Emergency Contact RelationShip";
                                    Stud."Emergency Contact Phone No." := Rec."Emergency Contact Phone No.";
                                    Stud."Emergency Contact Country Code" := Rec."Emergency Contact Country Code";
                                    Stud."Emergency Contact Postal Code" := Rec."Emergency Contact Postal Code";
                                    Stud."Emergency Contact City" := Rec."Emergency Contact City";
                                    Stud."Emergency Contact State" := Rec."Emergency Contact State";
                                    Stud.Validate("Academic Year", Rec."Academic Year");
                                    Stud."Local Emergency First Name" := Rec."Local Emergency First Name";
                                    Stud."Local Emergency Last Name" := Rec."Local Emergency Last Name";
                                    Stud."Local Emergency Email Address" := Rec."Local Emergency Email Address";
                                    Stud."Local Emergency Street Address" := Rec."Local Emergency Street Address";
                                    Stud."Local Emergency Phone No." := Rec."Local Emergency Phone No.";
                                    Stud."Local Emergency City" := Rec."Local Emergency City";
                                    Stud.Remarks := Rec.Remarks;
                                    Stud."Resident Address" := Rec."Resident Address";
                                    Stud."Resident Country" := Rec."Resident Country";
                                    Stud."Residency State" := Rec."Residency State";
                                    Stud."Resident City" := Rec."Resident City";
                                    Stud."Resident Zip Code" := Rec."Resident Zip Code";
                                    Stud."Name on Passport" := Rec."Name on Passport";
                                    Stud."Pass Port Expiry Date" := Rec."Pass Port Expiry Date";
                                    Stud."Pass Port Issued By" := Rec."Pass Port Issued By";
                                    Stud."Pass Port Issued Date" := Rec."Pass Port Issued Date";
                                    Stud."Pass Port No." := Rec."Pass Port No.";
                                    Stud."Permanent U.S. Resident" := Rec."Permanent U.S. Resident";
                                    Stud."Visa No." := Rec."Visa No.";
                                    Stud."Visa Expiry Date" := Rec."Visa Expiry Date";
                                    Stud."Visa Extension Date" := Rec."Visa Extension Date";
                                    Stud."Visa Issued Date" := Rec."Visa Issued Date";
                                    Stud."Immigration Expiration Date" := Rec."Immigration Expiration Date";
                                    Stud."Immigration Issuance Date" := Rec."Immigration Issuance Date";
                                    Stud."Flight Number" := Rec."Flight Number";
                                    Stud."Flight Arrival Date" := Rec."Flight Arrival Date";
                                    Stud."Flight Arrival Time" := Rec."Flight Arrival Time";
                                    Stud."Airline/Carrier" := Rec."Airline/Carrier";
                                    Stud."Departure Date from Antigua" := Rec."Departure Date from Antigua";
                                    Stud.Term := Rec.Term;
                                    Stud.Validate("Admitted Year", Rec."Admitted Year");
                                    Rec.CalcFields("Student Image");
                                    Stud."Student Image" := Rec."Student Image";
                                    Stud.Insert();
                                    Rec.CopyHoldAndGroups(Rec."No.", Stud."No.");
                                    //UpdateHoldAndGroup(Stud."No.");
                                    Currpage.SetRecord(Stud);
                                end;
                            end;
                        end;
                    }
                    group("Pre -Admission Details")
                    {
                        action("Enrolment History List")
                        {
                            Caption = 'Enrolment History List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // trigger OnAction()
                            // var
                            //     EnrollmentHistoryRec: Record "Enrollment History";
                            //     EnrollmentHistoryPag: Page "Enrollment History List";
                            // begin
                            //     EnrollmentHistoryRec.Reset();
                            //     EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                            //     Clear(EnrollmentHistoryPag);
                            //     EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                            //     if Rec."Entry From Salesforce" then begin
                            //         EnrollmentHistoryPag.Editable := false;
                            //         EnrollmentHistoryPag.Run();
                            //     end else begin
                            //         EnrollmentHistoryPag.Editable := true;
                            //         EnrollmentHistoryPag.Run();
                            //     end;
                            // end;
                        }

                        action("Student Buffer List")
                        {
                            Caption = 'Student List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Student Buffer Non API";
                            // RunPageLink = "18 Digit ID" = FIELD("18 Digit ID"), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }

                        action("Transaction Sync Buffer List")
                        {
                            Caption = 'Transaction Sync List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Transactions Sync Buffer List";
                            // RunPageLink = Account = FIELD("No."), "Void Entry" = filter(false);
                        }
                        action("Student Status Deferred/Declined Buffer List")
                        {
                            Caption = 'Student Status Deferred/Declined List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Deferred/Declined Buffer List";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Educational Qualification details")
                        {
                            Caption = 'Student Educational Qualification';
                            image = GanttChart;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                QualifyingDetailsRec: Record "Qualifying Detail Stud-CS";
                                QualifyingDetailsPag: Page "Qualifying Detail Stud List-CS";
                            begin
                                QualifyingDetailsRec.Reset();
                                QualifyingDetailsRec.Setrange("Student No.", Rec."No.");
                                Clear(QualifyingDetailsPag);
                                QualifyingDetailsPag.SetTableView(QualifyingDetailsRec);
                                if Rec."Entry From Salesforce" then begin
                                    QualifyingDetailsPag.Editable := false;
                                    QualifyingDetailsPag.Run();
                                end else begin
                                    QualifyingDetailsPag.Editable := true;
                                    QualifyingDetailsPag.Run();
                                end;
                            end;
                        }
                    }
                    group("Admission Details")
                    {
                        action("Pending Housing Application")
                        {
                            Caption = 'Pending Housing Application';
                            image = Home;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                Clear(HousingAppPag);
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");
                                HousingAppPag.SetTableView(HousingAppRec);
                                HousingAppPag.Run();

                            end;
                            // RunObject = Page "Housing Application List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Pending Housing Wavier Application Details")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier PendingApproval";
                            begin
                                Clear(HousingWaiverPag);
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");

                                HousingWaiverPag.SetTableView(OptOutRec);
                                HousingWaiverPag.Run();

                            end;

                            // RunObject = Page "Housing Wavier PendingApproval";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Student Course Subject Buffer List")
                        {
                            Caption = 'Student Course Subject List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Course Subject Buffer List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Approved/Rejected Housing App")
                        {
                            Caption = 'Approved/Rejected Housing Application List';
                            image = List;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Posted Housing Application";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");

                                HousingAppPag.SetTableView(HousingAppRec);
                                HousingAppPag.Run();

                            end;
                            // RunObject = Page "Posted Housing Application";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);
                        }
                        action("Approved/Rejected Housing Waiver")
                        {
                            Caption = 'Approved/Rejected Housing Waiver List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier Approved List";
                            begin
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");
                                // If OptOutRec.FindLast() then begin
                                HousingWaiverPag.SetTableView(OptOutRec);
                                HousingWaiverPag.Run();
                                // end;
                            end;
                            // RunObject = Page "Housing Wavier Approved List";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester);

                        }
                    }

                }

                group("Registrar/Academics")
                {
                    Visible = RegistrarGroup;
                    action("Create Next EnrollmentR")
                    {
                        Caption = 'Create Next Enrollment';
                        Image = NewCustomer;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            Stud: Record "Student Master-CS";
                            // StudBufferList: Page "Student Buffer List";
                            ExtraChar: Code[1];
                            InstCode: Code[20];
                            StudCount: Integer;
                            Selection: Integer;
                            InstituteCodeQuest: Label '&AUA,A&ICASA';
                            DefaultOption: Integer;
                        begin
                            if confirm('Do you want to create New Enrollment for the Student No. %1', false, Rec."Original Student No.") then begin
                                Selection := StrMenu(InstituteCodeQuest, DefaultOption);
                                if Selection > 0 then begin
                                    if Selection = 1 then
                                        InstCode := '9000'
                                    else
                                        if Selection = 2 then
                                            InstCode := '9100';
                                    Stud.Reset();
                                    Stud.SetRange("Original Student No.", Rec."Original Student No.");
                                    if Stud.FindFirst() then
                                        if Stud."Enrollment No." = '' then
                                            Error('You need to assign Program Code for the Student No. %1, Enrollment No. %2', Stud."No.", Stud."Enrollment No.");
                                    Stud.Reset();
                                    Stud.SetRange("Original Student No.", Rec."Original Student No.");
                                    StudCount := Stud.Count();
                                    Stud.Reset();
                                    Stud.Init();
                                    // Stud.Validate("Enrollment Order", StudBufferList.CreateStudentNo("Original Student No.", ExtraChar));
                                    Stud.Validate("No.", (Rec."Original Student No." + ExtraChar));
                                    Stud.validate("Original Student No.", Rec."Original Student No.");
                                    Stud.Validate("Parent Student No.", Rec."Original Student No.");
                                    Stud.Validate("18 Digit ID", Rec."18 Digit ID");
                                    Stud.Validate("Global Dimension 1 Code", InstCode);
                                    Stud.Validate("First Name", Rec."First Name");
                                    Stud.Validate("Last Name", Rec."Last Name");
                                    Stud.Validate(Title, Rec.Title);
                                    Stud.Validate("Middle Name", Rec."Middle Name");
                                    Stud.Validate("Maiden Name", Rec."Maiden Name");
                                    Stud.Validate("Marital Status", Rec."Marital Status");
                                    Stud.Validate("Social Security No.", Rec."Social Security No.");
                                    Stud.Validate("Date of Birth", Rec."Date of Birth");
                                    Stud.Validate(Gender, Rec.Gender);
                                    Stud.Validate("Fathers Name", Rec."Fathers Name");
                                    Stud.Validate("Father Contact Number", Rec."Father Contact Number");
                                    Stud.Validate("Father Email ID", Rec."Father Email ID");
                                    Stud.Validate("Mothers Name", Rec."Mothers Name");
                                    Stud.Validate("Mother Contact Number", Rec."Mother Contact Number");
                                    Stud.Validate("Mother Email ID", Rec."Mother Email ID");
                                    Stud.Validate(Addressee, Rec.Addressee);
                                    Stud.Address1 := Rec.Address1;
                                    Stud.Address2 := Rec.Address2;
                                    Stud."Country Code" := Rec."Country Code";
                                    Stud."Post Code" := Rec."Post Code";
                                    Stud.City := Rec.City;
                                    Stud.State := Rec.State;
                                    Stud.Address3 := Rec.Address3;
                                    Stud.Address4 := Rec.Address4;
                                    Stud."Cor Country Code" := Rec."Cor Country Code";
                                    Stud."Cor Post Code" := Rec."Cor Post Code";
                                    Stud."Cor City" := Rec."Cor City";
                                    Stud."Cor State" := Rec."Cor State";
                                    Stud."Same As Permanent Address" := Rec."Same As Permanent Address";
                                    Stud."Communication Address" := Rec."Communication Address";
                                    Stud."E-Mail Address" := Rec."E-Mail Address";
                                    Stud."Phone Number" := Rec."Phone Number";
                                    Stud."Mobile Number" := Rec."Mobile Number";
                                    Stud.Nationality := Rec.Nationality;
                                    Stud.Citizenship := Rec.Citizenship;
                                    Stud.Validate("Alternate Email Address", Rec."Alternate Email Address");
                                    Stud."Emergency Contact First Name" := Rec."Emergency Contact First Name";
                                    Stud."Emergency Contact Last Name" := Rec."Emergency Contact Last Name";
                                    Stud."Emergency Contact E-Mail" := Rec."Emergency Contact E-Mail";
                                    Stud."Emergency Contact Address" := Rec."Emergency Contact Address";
                                    Stud."Emergency Contact RelationShip" := Rec."Emergency Contact RelationShip";
                                    Stud."Emergency Contact Phone No." := Rec."Emergency Contact Phone No.";
                                    Stud."Emergency Contact Country Code" := Rec."Emergency Contact Country Code";
                                    Stud."Emergency Contact Postal Code" := Rec."Emergency Contact Postal Code";
                                    Stud."Emergency Contact City" := Rec."Emergency Contact City";
                                    Stud."Emergency Contact State" := Rec."Emergency Contact State";
                                    Stud.Validate("Academic Year", Rec."Academic Year");
                                    Stud."Local Emergency First Name" := Rec."Local Emergency First Name";
                                    Stud."Local Emergency Last Name" := Rec."Local Emergency Last Name";
                                    Stud."Local Emergency Email Address" := Rec."Local Emergency Email Address";
                                    Stud."Local Emergency Street Address" := Rec."Local Emergency Street Address";
                                    Stud."Local Emergency Phone No." := Rec."Local Emergency Phone No.";
                                    Stud."Local Emergency City" := Rec."Local Emergency City";
                                    Stud.Remarks := Rec.Remarks;
                                    Stud."Resident Address" := Rec."Resident Address";
                                    Stud."Resident Country" := Rec."Resident Country";
                                    Stud."Residency State" := Rec."Residency State";
                                    Stud."Resident City" := Rec."Resident City";
                                    Stud."Resident Zip Code" := Rec."Resident Zip Code";
                                    Stud."Name on Passport" := Rec."Name on Passport";
                                    Stud."Pass Port Expiry Date" := Rec."Pass Port Expiry Date";
                                    Stud."Pass Port Issued By" := Rec."Pass Port Issued By";
                                    Stud."Pass Port Issued Date" := Rec."Pass Port Issued Date";
                                    Stud."Pass Port No." := Rec."Pass Port No.";
                                    Stud."Permanent U.S. Resident" := Rec."Permanent U.S. Resident";
                                    Stud."Visa No." := Rec."Visa No.";
                                    Stud."Visa Expiry Date" := Rec."Visa Expiry Date";
                                    Stud."Visa Extension Date" := Rec."Visa Extension Date";
                                    Stud."Visa Issued Date" := Rec."Visa Issued Date";
                                    Stud."Immigration Expiration Date" := Rec."Immigration Expiration Date";
                                    Stud."Immigration Issuance Date" := Rec."Immigration Issuance Date";
                                    Stud."Flight Number" := Rec."Flight Number";
                                    Stud."Flight Arrival Date" := Rec."Flight Arrival Date";
                                    Stud."Flight Arrival Time" := Rec."Flight Arrival Time";
                                    Stud."Airline/Carrier" := Rec."Airline/Carrier";
                                    Stud."Departure Date from Antigua" := Rec."Departure Date from Antigua";
                                    Stud.Term := Rec.Term;
                                    Stud.Validate("Admitted Year", Rec."Admitted Year");
                                    Rec.CalcFields("Student Image");
                                    Stud."Student Image" := Rec."Student Image";
                                    Stud.Insert();
                                    Rec.CopyHoldAndGroups(Rec."No.", Stud."No.");
                                    //UpdateHoldAndGroup(Stud."No.");
                                    Currpage.SetRecord(Stud);
                                end;
                            end;
                        end;
                    }
                    group(OLR)
                    {
                        Caption = 'OLR';
                        Action("Send back to Dashboard")
                        {
                            Image = NewCustomer;
                            trigger OnAction()
                            var
                                StatusChangeLog: Record "Status Change Log entry";
                                DepartmentApprover: Record "Document Approver Users";
                                StudentTimeLine: Record "Student time line";
                            Begin

                                DepartmentApprover.Reset();
                                DepartmentApprover.Setrange("User ID", UserId());
                                DepartmentApprover.SetRange("Department Approver Type", DepartmentApprover."Department Approver Type"::"Registrar Department");
                                IF not DepartmentApprover.FindFirst() then
                                    Error('You do not have permission to perform this activity!');

                                IF not confirm('Do you want to show dashboard on Student Portal?', False) then
                                    Exit;

                                StatusChangeLog.Reset();
                                StatusChangeLog.Setrange("Student No.", Rec."No.");
                                StatusChangeLog.Setrange("Status Change to", 'ENR');
                                IF StatusChangeLog.FindLast() then
                                    Rec.Validate(Status, StatusChangeLog."Status change From");

                                Rec."Registrar Signoff" := True;
                                Rec.Modify();

                                StudentTimeLine.InsertRecordFun(Rec."No.", Rec."Student Name", 'Send back to dashboard has been performed by ' + USerID(), UserID(), Today());
                            End;
                        }
                        Action("Send Back to OLR")
                        {
                            Image = NewCustomer;
                            Trigger OnAction()
                            Var

                                HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
                            Begin

                                USerSetupApprover.Reset();
                                USerSetupApprover.Setrange("User ID", USerID());
                                USerSetupApprover.Setrange("Department Approver Type", usersetupapprover."Department Approver Type"::"Registrar Department");
                                USerSetupApprover.Findfirst();

                                Rec.Testfield("Registrar SignOff", False);

                                If not Confirm('Do you want to clear Student OLR Information?', False) then
                                    Exit;
                                Rec.Validate(Status, 'ENR');
                                Rec."OLR Completed" := False;
                                Rec."OLR Completed Date" := 0D;
                                If Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In" then
                                    HoldUpdate_lCU.OnGroundCheckInStudentGroupDisable(Rec."No.");
                                If Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In Completed" then
                                    HoldUpdate_lCU.OnGroundCheckInCompletedGroupDisable(Rec."No.");
                                Rec."Student Group" := Rec."Student Group"::" ";
                                Rec."On Ground Check-In By" := '';
                                Rec."On Ground Check-In On" := 0D;
                                Rec."On Ground Check-In Complete By" := '';
                                Rec."On Ground Check-In Complete On" := 0D;
                                Rec.Modify();
                            End;
                        }
                        action("Student Registration Details")
                        {
                            Caption = 'Student Registration Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                StudentRegistrationRec: Record "Student Registration-CS";
                                StudentRegistrationlistPag: Page "Student Registration list";
                            begin
                                StudentRegistrationRec.Reset();
                                StudentRegistrationRec.SetCurrentKey("Created On");
                                StudentRegistrationRec.SetRange("Student No", Rec."No.");
                                StudentRegistrationlistPag.SetTableView(StudentRegistrationRec);
                                StudentRegistrationlistPag.Run();

                            end;

                            // RunObject = Page "Student Registration list";
                            // RunPageLink = "Student No" = FIELD("No."), "Academic Year" = field("Academic Year"),
                            //        Semester = field(Semester), Term = Field(Term);
                        }
                        action("FERPA Details")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            Visible = HideFerpaDetail;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                                FerpaPag: Page "FERPA Details List";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                //If FerpaRec.FindLast() then begin
                                FerpaPag.SetTableView(FerpaRec);
                                FerpaPag.Run();
                                //end;
                            end;

                            // RunObject = Page "FERPA Details List";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("FERPA Details_I")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            Visible = ShowFerpaDetail;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                            // FerpaPag: Page "FERPA Details Lists";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                // If FerpaRec.FindLast() then begin
                                // FerpaPag.SetTableView(FerpaRec);
                                // FerpaPag.SetVariable(Rec."No.");
                                // FerpaPag.Run();
                                // end;
                            end;
                            // RunObject = Page "FERPA Details List";
                            // RunPageLink = "Student No." = FIELD("No."), "Academic Year" = field("Academic Year"),
                            //        Semester = field(Semester);
                        }
                        action("Agreement List")
                        {
                            Caption = 'Agreement List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                        }

                        action("Digital Signature List")
                        {
                            Caption = 'Digital Signature List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Digital Signature List";
                            RunPageLink = "Signatory/User ID" = Field("No.");
                        }
                        action("Student Ethnicity List")
                        {
                            Caption = 'Student Ethnicity List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            // RunObject = Page "Student Ethnicity List";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("ID Card")
                        {
                            Caption = 'ID Card';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                RecStudentMaster: Record "Student Master-CS";
                            begin
                                //RunObject = Report "AICASA IDCard";
                                if Rec."Global Dimension 1 Code" = '9100' then begin
                                    RecStudentMaster.Reset();
                                    RecStudentMaster.SetRange("No.", Rec."No.");
                                    IF RecStudentMaster.FindFirst() then begin
                                        Report.Run(Report::"AICASA IDCard", true, false, RecStudentMaster);
                                    end;
                                end;
                                // RunObject = Report "AUA Basic Science IDCard";
                                if Rec."Global Dimension 1 Code" = '9000' then begin
                                    if (Rec.Semester = 'MED1') or (Rec.Semester = 'MED2') or (Rec.Semester = 'MED3') or (Rec.Semester = 'MED4') or (Rec.Semester = 'BSIC') then begin
                                        RecStudentMaster.Reset();
                                        RecStudentMaster.SetRange("No.", Rec."No.");
                                        IF RecStudentMaster.FindFirst() then begin
                                            Report.Run(Report::"AUA Basic Science IDCard", true, false, RecStudentMaster);
                                        end;
                                    end;
                                end;
                                //RunObject = Report "AUA 5th Semester IDCard";
                                if Rec."Global Dimension 1 Code" = '9000' then begin
                                    if (Rec.Semester = 'CLN5') or (Rec.Semester = 'CLN6') or (Rec.Semester = 'CLN7') or (Rec.Semester = 'CLN8') or (Rec.Semester = 'CLN9') then begin
                                        RecStudentMaster.Reset();
                                        RecStudentMaster.SetRange("No.", Rec."No.");
                                        IF RecStudentMaster.FindFirst() then begin
                                            Report.Run(Report::"AUA 5th Semester IDCard", true, false, RecStudentMaster);
                                        end;
                                    end;
                                end;

                            end;

                        }
                        action("Generate QRCode")
                        {
                            Image = BarCode;
                            ApplicationArea = All;
                            trigger OnAction()
                            begin
                                IF Confirm('Do you want to generate QR Code ?', false) then begin
                                    Rec.GenerateBarCodeNew(Rec);
                                end;

                            end;
                        }
                    }
                    Group("Pending Applications")
                    {
                        action("Pending Housing Applications")
                        {
                            Caption = 'Pending Housing Application';
                            image = Home;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");
                                If HousingAppRec.FindLast() then begin
                                    HousingAppPag.SetTableView(HousingAppRec);
                                    HousingAppPag.Run();
                                end;
                            end;
                            // RunObject = Page "Housing Application List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }

                        action("Pending Housing Wavier Application")
                        {
                            Caption = 'Pending Housing Wavier Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            trigger OnAction()
                            var
                                OptOutRec: Record "Opt Out";
                                HousingWaiverPag: Page "Housing Wavier PendingApproval";
                            begin
                                OptOutRec.Reset();
                                OptOutRec.SetCurrentKey("Created On");
                                OptOutRec.SetRange("Student No.", Rec."No.");
                                If OptOutRec.FindLast() then begin
                                    HousingWaiverPag.SetTableView(OptOutRec);
                                    HousingWaiverPag.Run();
                                end;
                            end;

                            // RunObject = Page "Housing Wavier PendingApproval";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Pending Withdrawal Application")
                        {
                            Caption = 'Pending Withdrawal Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Withdrawal Approvals";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Pending Leave Application")
                        {
                            Caption = 'Pending Leave Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            // RunObject = Page "Pending Leaves Approvals";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Pending Re-registration Application")
                        {
                            Caption = 'Pending Re-registration Application';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            // RunObject = Page "Housing Re-Registration List";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                    }
                    Group("Posted Applications")
                    {
                        action("Post Housing Application")
                        {
                            Caption = 'Posted Housing Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Posted Housing Waiver Application")
                        {
                            Caption = 'Posted Housing Waiver Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Posted Withdrawal Application")
                        {
                            Caption = 'Posted Withdrawal Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            RunObject = Page "Withdrawal Approval Status";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Posted Re-registration Application")
                        {
                            Caption = 'Posted Re-registration Application';
                            image = PostApplication;

                            ApplicationArea = All;
                            // RunObject = Page "Approve Reject Re-Registration";
                            // RunPageLink = "Student No." = FIELD("No."),
                            //                Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                    }
                    group("Registrar_1")
                    {
                        Caption = 'Registrar';
                        action("Student Group Code")
                        {
                            Caption = 'Student Group';
                            Image = EntriesList;
                            ApplicationArea = All;

                            // RunObject = Page "Student Group";
                            // RunPageLink = "Student No." = FIELD("No.");

                        }

                        action("Student Group Ledger")
                        {
                            Caption = 'Student Group Ledger';
                            Image = EntriesList;
                            ApplicationArea = All;

                            // RunObject = Page "Student Group Ledger";
                            // RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Change Status")
                        {
                            Image = ChangeStatus;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                UserSetup: Record "User Setup";
                                StudentMaster: Record "Student Master-CS";
                            // StudentStatus: Page "Student Status Change Manually";

                            begin
                                usersetupapprover.Reset();
                                usersetupapprover.setrange("User ID", UserId());
                                usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Registrar Department");
                                IF not usersetupapprover.FindFirst() then
                                    error('You are not authorized. This functionality can be handled by "Registrar Department"');
                                // UserSetup.get(Userid());
                                // if UserSetup."Department Approver" <> Usersetup."Department Approver"::"Registrar Department" then
                                //     Error('You are not authorized. This functionality can be handled by "Registrar Department"');

                                // StudentMaster.Reset();
                                // StudentMaster.SetRange("No.", Rec."No.");
                                // If StudentMaster.FindFirst() then begin
                                //     StudentStatus.SetTableView(StudentMaster);
                                //     StudentStatus.Run();
                                // end;
                                // StudentStatus.GetStudent(Rec."No.");
                                // StudentStatus.Run();

                            end;

                        }
                        action("Student Residency Detail")
                        {
                            Caption = 'Student Residency Detail';
                            Image = EntriesList;
                            ApplicationArea = All;

                            // trigger OnAction()
                            // var
                            //     StudentMaster: Record "Student Master-CS";
                            //     Residency: Record Residency;
                            //     ResidencyDetails: Page "Residency Card";
                            // begin
                            //     Residency.Reset();
                            //     Residency.SetRange("Student No.", Rec."No.");
                            //     If Residency.FindFirst() then begin
                            //         ResidencyDetails.SetTableView(Residency);
                            //         ResidencyDetails.Editable(false);
                            //         ResidencyDetails.Run();
                            //     end;
                            // end;
                        }
                        action("Student Subject Mapping")
                        {
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentMasterRec: Record "Student Master-CS";
                            begin
                                StudentMasterRec.Reset();
                                StudentMasterRec.SetRange("No.", Rec."No.");
                                If StudentMasterRec.FindFirst() then
                                    Report.Run(Report::"Student Subject Mapping", True, False, StudentMasterRec);

                            end;
                        }
                        action("Student Immigration List")
                        {
                            Caption = 'Student Immigration List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                ImmigrationHeader: Record "Immigration Header";
                                ImmigrationList: Page "Immigration list";
                            begin
                                ImmigrationHeader.Reset();
                                ImmigrationHeader.SetRange("Student No", Rec."No.");
                                ImmigrationHeader.SetRange(Semester, Rec.Semester);
                                Clear(ImmigrationList);
                                ImmigrationList.SetTableView(ImmigrationHeader);
                                ImmigrationList.Editable := false;
                                ImmigrationList.Run();
                            end;

                        }
                        action("Student Wise Hold")
                        {
                            Caption = 'Student Holds';
                            ApplicationArea = All;
                            Image = Ledger;
                            RunObject = Page "Student Wise Hold List";
                            //RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                            RunPageLink = "Student No." = field("No.");
                            RunPageView = SORTING("Student No.");
                            ShortCutKey = 'Ctrl+F8';
                        }
                        action("Student Hold Ledger")
                        {
                            Caption = 'Student Hold Ledger';
                            ApplicationArea = All;
                            Image = Ledger;
                            RunObject = Page "Hold Status Ledger List";
                            RunPageLink = "Student No." = field("No.");
                            RunPageView = SORTING("Student No.");
                        }

                        action("List of RotationsR")
                        {
                            Caption = 'List of Rotation(s)';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                RSL: Record "Roster Scheduling Line";
                            begin
                                RSL.Reset();
                                RSL.SetCurrentKey("Student No.", "Start Date");
                                RSL.FilterGroup(2);
                                RSL.SetRange("Student No.", Rec."No.");
                                //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                                RSL.FilterGroup(2);
                                Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                            end;
                        }
                        action("Page Cust Ledger Entries")
                        {
                            ApplicationArea = All;
                            Caption = 'Ledger E&ntries';
                            Image = CustomerLedger;
                            RunObject = Page "Customer Ledger Entries";
                            RunPageLink = "Customer No." = FIELD("Original Student No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                            RunPageView = SORTING("Customer No.");
                            ShortCutKey = 'Ctrl+F7';
                        }
                        action("Faculty Feedback Results")
                        {
                            Caption = 'Faculty Feedback Results';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Feedback Detail-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Student timeline")
                        {
                            Caption = 'Student timeline';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Student Time Line";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Status Change Log Entries")
                        {
                            Caption = 'Status Change Log Entries';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Status Change Log Entries";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("E-Mail Notification List")
                        {
                            Caption = 'E-Mail Notification List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Trigger OnAction()
                            var
                                EmailnotificationRec: Record "Email Notification";
                                EmailNotificationPage: Page "E-Mail Notification List";
                            Begin
                                Clear(EmailNotificationPage);
                                EmailnotificationRec.Reset();
                                EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                                EmailNotificationPage.SetTableView(EmailnotificationRec);
                                EmailNotificationPage.Run();
                            End;
                        }
                        action("Inter Log Entry Reg")
                        {
                            Caption = 'Interaction Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Transfer Credit Details")
                        {
                            Caption = 'Transfer Credit Details';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Student Branch Tranfr Dtl-CS";
                            RunPageLink = "No." = FIELD("No."), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Course Degree List")
                        {
                            ApplicationArea = All;
                            Caption = 'Course Degree List';
                            Image = EntriesList;
                            // trigger OnAction()
                            // var
                            //     TempCourseDegreeList: Page "Temp Course Degree List";
                            // begin
                            //     TempCourseDegreeList.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                            //     TempCourseDegreeList.RunModal();
                            // end;
                        }
                        action("Student Honors1")
                        {
                            ApplicationArea = All;
                            Caption = 'Student Honors';
                            Image = EntriesList;
                            // RunObject = Page "Student Honors";
                            // RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Student Exam Change Log")
                        {
                            Caption = 'Student Exam Change Log';
                            Image = Log;
                            // RunObject = page "Student Exam Change Log";
                            // RunPageLink = "Student No." = field("No.");
                        }
                        action("Student Subject Change Log")
                        {
                            Caption = 'Student Subject Change Log';
                            Image = Log;
                            // RunObject = page "Student Subject Change Log";
                            // RunPageLink = "Student No." = field("No.");
                        }
                    }
                    group("Academics_1")
                    {
                        Caption = 'Academics';
                        action("Student Attendance Detail")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;

                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."),
                                           Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Student GPA Calculation")
                        {
                            Caption = 'Student GPA Calculation';
                            Image = Calculate;
                            ApplicationArea = All;
                            RunObject = page StudentGPACalculation;
                            RunPageLink = "Original Student No." = field("Original Student No.");
                        }

                        Action("Student Advisor Details")
                        {
                            Caption = 'Student Advisor Details';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Student Advisor Detail";
                            RunPageLink = "Student No." = field("No.");
                        }
                        action("&Student Subject")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "ORiginal student No." = field("Original Student No.");

                        }
                        action("Student Subject Exams")
                        {
                            Caption = 'Student Subject Exams';
                            Image = List;
                            ApplicationArea = All;
                            // RunObject = Page "Student Subject Exam List";
                            // RunPageLink = "Student No." = FIELD("No.");


                        }
                        group("Clinical Clerkship Assessment")
                        {
                            Image = AdjustEntries;
                            action("Clerkship Assessment")
                            {
                                ApplicationArea = All;
                                Caption = 'Clerkship Assessment';
                                Image = AdjustItemCost;
                                trigger OnAction()
                                var
                                    RLE: Record "Roster Ledger Entry";
                                Begin
                                    RLE.Reset();
                                    RLE.FilterGroup(2);
                                    RLE.SetRange("Student ID", Rec."No.");
                                    RLE.SetFilter("Rotation Grade", '%1|%2', '', 'M');
                                    RLE.SetFilter("Start Date", '<=%1', Today);
                                    RLE.FilterGroup(0);
                                    // Page.RunModal(Page::"RLE Clerkship Assessment", RLE);
                                End;
                            }
                            action("Saved Clerkship Assessment")
                            {
                                ApplicationArea = All;
                                Caption = 'Saved Clerkship Assessment';
                                Image = OutputJournal;
                                trigger OnAction()
                                var
                                    DocuSignAssessment: Record "DocuSign Assessment Scores";
                                Begin
                                    DocuSignAssessment.Reset();
                                    DocuSignAssessment.FilterGroup(2);
                                    DocuSignAssessment.SetRange("Student No.", Rec."No.");
                                    DocuSignAssessment.FilterGroup(0);
                                    Page.RunModal(Page::"DocuSign Assessment Scores", DocuSignAssessment);
                                End;
                            }
                            action("Published Clerkship Assessment")
                            {
                                ApplicationArea = All;
                                Caption = 'Published Clerkship Assessment';
                                Image = AdjustItemCost;
                                trigger OnAction()
                                var
                                    DocuSignAssessment: Record "DocuSign Assessment Scores";
                                Begin
                                    DocuSignAssessment.Reset();
                                    DocuSignAssessment.FilterGroup(2);
                                    DocuSignAssessment.SetRange("Student No.", Rec."No.");
                                    DocuSignAssessment.FilterGroup(0);
                                    // Page.RunModal(Page::"DocuSign Assessment Scores+", DocuSignAssessment);
                                End;
                            }
                        }
                        // action("Student &Optional Subject")
                        // {
                        //     Caption = 'Student &Optional Subjects';
                        //     image = GanttChart;
                        //     ApplicationArea = All;

                        //     RunObject = Page 50004;
                        //     RunPageLink = "Student No." = FIELD("No."),
                        //           "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        // }

                        action("Student Assessment List")
                        {
                            Caption = 'Student Assignment List';
                            Image = GanttChart;
                            RunObject = Page 50039;
                            ApplicationArea = All;

                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Semester GPA Detail")
                        {
                            ApplicationArea = All;
                            Caption = 'Semester GPA Details';
                            Image = EntriesList;

                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                // SemesterGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail")
                        {
                            Caption = 'Year GPA Detail';
                            Image = EntriesList;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                // YearGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Status History")
                        {
                            Caption = 'Status History';
                            Image = EntriesList;
                            ApplicationArea = All;

                        }

                        action("Student Promotion List4")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }

                        action("CCSE Score_2")
                        {
                            caption = 'CCSE Score';
                            ApplicationArea = All;
                            Image = List;
                            // Promoted = true;
                            // PromotedOnly = true;
                            // PromotedIsBig = true;
                            // PromotedCategory = Process;
                            // RunObject = page "Student Subject Exam List";
                            // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSE);
                        }
                        action("CCSSE Score_2 ")
                        {
                            caption = 'CCSSE Score';
                            ApplicationArea = All;
                            Image = List;
                            // Promoted = true;
                            // PromotedOnly = true;
                            // PromotedIsBig = true;
                            // PromotedCategory = Process;
                            // RunObject = page "Student Subject Exam List";
                            // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSSE);
                        }
                        action("CBSE Score_2")
                        {
                            Caption = 'CBSE Score';
                            ApplicationArea = All;
                            Image = List;
                            // Promoted = true;
                            // PromotedOnly = true;
                            // PromotedIsBig = true;
                            //PromotedCategory = Process;
                            // RunObject = page "Student Subject Exam List";
                            // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CBSE);
                        }
                        Action("USMLE Scores_1")
                        {
                            Caption = 'USMLE Scores';
                            Image = PostApplication;
                            ApplicationArea = All;
                            // RunObject = page "Student Subject Exam List";
                            // RunPageLink = "Original Student No." = Field("Original Student No."), "Score Type" = filter("STEP 1" | "STEP 2 CS" | "STEP 2 CK");
                        }
                    }
                    /*
                    group("Coordinators")
                    {
                        action("Student Basic Science Coordinator")
                        {
                            Caption = 'Student Basic Science Cordinator';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Student Clinical Details";
                            RunPageLink = "No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Student Clinical Coordinator")
                        {
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentMaster: Record "Student Master-CS";
                                StudentsWithClinicalUsers: Page "Students With Clinical Users";
                            begin
                                StudentMaster.Reset();
                                StudentMaster.FilterGroup(2);
                                StudentMaster.SetRange("No.", Rec."No.");
                                StudentMaster.FilterGroup(0);
                                StudentsWithClinicalUsers.SetVariable(true, True, True);
                            end;
                        }
                        action("Student EED Advisor")
                        {
                            Caption = 'Student EED Advisor';
                            image = GanttChart;
                            ApplicationArea = All;
                        }

                    }
                    */

                    group("Pre-Admission Details")
                    {
                        action("Enrolment History List1")
                        {
                            Caption = 'Enrolment History List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // trigger OnAction()
                            // var
                            //     EnrollmentHistoryRec: Record "Enrollment History";
                            //     EnrollmentHistoryPag: Page "Enrollment History List";
                            // begin
                            //     EnrollmentHistoryRec.Reset();
                            //     EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                            //     Clear(EnrollmentHistoryPag);
                            //     EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                            //     if Rec."Entry From Salesforce" then begin
                            //         EnrollmentHistoryPag.Editable := false;
                            //         EnrollmentHistoryPag.Run();
                            //     end else begin
                            //         EnrollmentHistoryPag.Editable := true;
                            //         EnrollmentHistoryPag.Run();
                            //     end;
                            // end;
                        }
                        action("Student Buffer List1")
                        {
                            Caption = 'Student List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Student Buffer Non API";
                            // RunPageLink = "18 Digit ID" = FIELD("18 Digit ID"), Semester = Field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Transaction Sync Buffer List1")
                        {
                            Caption = 'Transaction Sync List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Transactions Sync Buffer List";
                            // RunPageLink = Account = FIELD("No.");
                        }
                        action("Student Status Deferred/Declined Buffer List1")
                        {
                            Caption = 'Student Status Deferred/Declined List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Deferred/Declined Buffer List";
                            // RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Student Educational Qualification Details1")
                        {
                            Caption = 'Student Educational Qualification';
                            image = GanttChart;
                            ApplicationArea = All;
                            // trigger OnAction()
                            // var
                            //     QualifyingDetailsRec: Record "Qualifying Detail Stud-CS";
                            //     QualifyingDetailsPag: Page "Qualifying Detail Stud List-CS";
                            // begin
                            //     QualifyingDetailsRec.Reset();
                            //     QualifyingDetailsRec.Setrange("Student No.", Rec."No.");
                            //     Clear(QualifyingDetailsPag);
                            //     QualifyingDetailsPag.SetTableView(QualifyingDetailsRec);
                            //     if Rec."Entry From Salesforce" then begin
                            //         QualifyingDetailsPag.Editable := false;
                            //         QualifyingDetailsPag.Run();
                            //     end else begin
                            //         QualifyingDetailsPag.Editable := true;
                            //         QualifyingDetailsPag.Run();
                            //     end;
                            // end;
                        }

                    }
                    group("Student TranscriptsR1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official Transcripts")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsR")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsPrint2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official Transcripts1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial Transcripts1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsPrint3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official Transcripts3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial Transcripts2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsR1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsPrint5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official Transcripts1Print5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial Transcripts1Print5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsPrint6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official Transcripts6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial Transcripts6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }

                }
                group("Clinical_Rotation")
                {
                    Visible = ClinicalDetailsGroup;
                    Caption = 'Clinical';
                    // action("Rotation Audit")
                    // {
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    //     Caption = 'Rotation Audit';
                    //     trigger OnAction()
                    //     var
                    //         StudentMaster: Record "Student Master-CS";
                    //         StudentsRotationAudit: Page "Students Rotation Audit";
                    //     begin
                    //         StudentMaster.Reset();
                    //         StudentMaster.FilterGroup(2);
                    //         StudentMaster.SetRange("No.", Rec."No.");
                    //         StudentMaster.FilterGroup(0);
                    //         StudentsRotationAudit.Setvariables(true);
                    //         StudentsRotationAudit.SetTableView(StudentMaster);
                    //         StudentsRotationAudit.RunModal();
                    //     end;
                    // }

                    // action("Clincal Documents")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Clincal Documents';
                    //     Image = Documents;
                    //     trigger OnAction()
                    //     var
                    //         StudentDocumentAttachment: Record "Student Document Attachment";
                    //     begin
                    //         StudentDocumentAttachment.Reset();
                    //         StudentDocumentAttachment.FilterGroup(2);
                    //         StudentDocumentAttachment.SetRange("Student No.", Rec."No.");
                    //         StudentDocumentAttachment.FilterGroup(0);
                    //         Page.RunModal(Page::"Audit Clinical Documents", StudentDocumentAttachment);
                    //     end;
                    // }
                    action("Preferred Site and Date Selection")
                    {
                        Caption = 'Preferred Site and Date Selection';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "STDClkshpSite_DateSelectionLST";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");
                    }
                    action("Preferred Site And Date List")
                    {
                        Caption = 'Preferred Site And Date List';
                        image = List;
                        ApplicationArea = All;
                        RunObject = page "UNVClkshpSite_DateLST+";
                        RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");
                    }
                    action("List of Rotations")
                    {
                        Caption = 'List of Rotation(s)';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Group Code(Elective) List-CS";
                        RunPageLink = "Student No." = field("No.");
                        RunPageMode = View;
                        // trigger OnAction()
                        // var
                        //     RSL: Record "Roster Scheduling Line";
                        // begin
                        //     RSL.Reset();
                        //     RSL.SetCurrentKey("Student No.", "Start Date");
                        //     RSL.FilterGroup(2);
                        //     RSL.SetRange("Student No.", Rec."No.");
                        //     //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                        //     RSL.FilterGroup(2);
                        //     Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        // end;
                    }
                    action("Elective Rotations")
                    {
                        Caption = 'Elective Rotations';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Visible = false;
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Elective);
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }

                    action("FM1/IM1 Rotation")
                    {
                        Caption = 'FM1/IM1 Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Visible = false;
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::"FM1/IM1");
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }
                    action("Roster Ledger Entries")
                    {
                        Caption = 'Roster Ledger Entries';
                        Image = LedgerEntries;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            RLE: Record "Roster Ledger Entry";
                        begin
                            RLE.Reset();
                            RLE.SetCurrentKey("Start Date");
                            RLE.Ascending(false);
                            RLE.FilterGroup(2);
                            RLE.SetRange("Student ID", Rec."No.");
                            RLE.FilterGroup(2);
                            Page.RunModal(Page::"Roster Ledger Entries", RLE)
                        end;
                    }

                    action("FERPA DetailC")
                    {
                        Caption = 'FERPA Details';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        trigger OnAction()
                        var
                            FerpaRec: Record "FERPA Details";
                            FerpaPag: Page "FERPA Details List";
                        begin
                            FerpaRec.Reset();
                            FerpaRec.SetCurrentKey("Created On");
                            FerpaRec.SetRange("Student No.", Rec."No.");
                            //If FerpaRec.FindLast() then begin
                            FerpaPag.SetTableView(FerpaRec);
                            FerpaPag.Run();
                            //end;
                        end;

                        // RunObject = Page "FERPA Details List";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("Student Hold Ledger CLN")
                    {
                        Caption = 'Student Hold Ledger';
                        ApplicationArea = All;
                        Image = Ledger;
                        RunObject = Page "Hold Status Ledger List";
                        RunPageLink = "Student No." = field("No.");
                        RunPageView = SORTING("Student No.");
                    }

                    //CS:NS:05-04-2021   -----Start
                    // action("Student Subject ExamsCln")
                    // {
                    //     Caption = 'Student Subject Exams';
                    //     Image = List;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Student Subject Exam List";
                    //     RunPageLink = "Student No." = FIELD("No.");

                    // }
                    //CS:NS:05-04-2021   -----End

                    action("Student Hold Leader")
                    { //CSPL-00307 // 18-10-21
                        Caption = 'Student Hold Leader';
                        image = Account;
                        ApplicationArea = All;
                        RunObject = page "Hold Status Ledger List";
                        RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("Put on Clinical Hold")
                    {
                        ApplicationArea = All;
                        Caption = 'Put on Clinical Hold';
                        Image = Holiday;
                        // Promoted = true;
                        // PromotedCategory = Process;
                        // PromotedOnly = true;

                        trigger OnAction()
                        var
                            StudentMaster: Record "Student Master-CS";
                        begin
                            StudentMaster.Reset();
                            StudentMaster.FilterGroup(2);
                            StudentMaster.SetRange("No.", Rec."No.");
                            StudentMaster.FilterGroup(0);
                            Page.RunModal(Page::"Clinical Hold Reason Input", StudentMaster);
                        end;
                    }
                }
                group("Clinical Details")
                {
                    Visible = false;

                    action("Stud Attendance Details")
                    {
                        Caption = 'Student Attendance Detail';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Attendance Student Line-CS";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                    }
                    // action("Semester GPA Details")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Semester GPA Details';
                    //     Image = EntriesList;
                    //     trigger OnAction()
                    //     var
                    //         SemesterGPATemp: Page "Semester GPA";
                    //     begin
                    //         SemesterGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                    //         SemesterGPATemp.RunModal();
                    //     end;
                    // }
                    // action("Year GPA Details")
                    // {
                    //     Caption = 'Year GPA Detail';
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    //     trigger OnAction()
                    //     var
                    //         YearGPATemp: Page "Year GPA";
                    //     begin
                    //         YearGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                    //         YearGPATemp.RunModal();
                    //     end;
                    // }

                    action("Student Promotion List")
                    {
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                    }

                    group("Legacy Data4")
                    {
                        Caption = 'Legacy Data';
                        action("Roster Ledger Entry")
                        {
                            Caption = 'Roster Ledger Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Roster Ledger Entries";
                            RunPageLink = "Student ID" = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }

                }
                group(Housing)
                {
                    Visible = HousingGroup;
                    Caption = 'Housing';
                    action("Housing Sign Off")
                    {
                        Caption = 'Housing SignImmigrat Off';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;

                    }
                    action("Immigration Document List")
                    {
                        Caption = 'Immigration Document List';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Immigration Document List";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        RunPageView = SORTING("Student No.");

                    }
                    action("Student Wise Hold1")
                    {
                        Caption = 'Student Holds';
                        ApplicationArea = All;
                        Image = Ledger;

                        RunObject = Page "Student Wise Hold List";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        RunPageView = SORTING("Student No.");
                        ShortCutKey = 'Ctrl+F8';

                    }

                    action("Housing Ledger")
                    {
                        Caption = 'Housing Ledger';
                        image = LedgerBook;
                        ApplicationArea = Basic, Suite;
                        //Promoted = true;
                        //PromotedCategory = Category8;
                        RunObject = Page "Housing Ledger";
                        // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                    }
                    Action("Email Notification List")
                    {
                        ApplicationArea = All;
                        Trigger OnAction()
                        var
                            EmailnotificationRec: Record "Email Notification";
                            EmailNotificationPage: Page "E-Mail Notification List";
                        Begin
                            Clear(EmailNotificationPage);
                            EmailnotificationRec.Reset();
                            EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                            EmailnotificationRec.SetFilter(Subject, '*Housing*');
                            EmailNotificationPage.SetTableView(EmailnotificationRec);
                            EmailNotificationPage.Run();
                        End;
                    }
                    group("Pending Applications ")
                    {
                        action("Pending Housing Wavier Application List1")
                        {
                            Caption = 'Pending Housing Wavier Application List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier PendingApproval";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        action("Pending Housing Applications List")
                        {
                            Caption = 'Pending Housing Applications List';
                            image = Home;
                            ApplicationArea = All;

                            trigger OnAction()
                            var
                                HousingAppRec: Record "Housing Application";
                                HousingAppPag: Page "Housing Application List";
                            begin
                                HousingAppRec.Reset();
                                HousingAppRec.SetCurrentKey("Created On");
                                HousingAppRec.SetRange("Student No.", Rec."No.");
                                If HousingAppRec.FindLast() then begin
                                    HousingAppPag.SetTableView(HousingAppRec);
                                    HousingAppPag.Run();
                                end;
                            end;
                            // RunObject = Page "Housing Application List";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }


                        action("Pending Housing Change List")
                        {
                            Caption = 'Pending Housing Change List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Change Request List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Pending Housing Vacate List")
                        {
                            Caption = 'Pending Housing Vacate List';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Vacate Request List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        // action("Pending Housing Re-registration List")
                        // {
                        //     Caption = 'Pending Housing Re-registration List';
                        //     image = PostApplication;
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Housing Re-Registration List";
                        //     RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        // }
                        action("Pending Housing Issue List")
                        {
                            Caption = 'Housing Issue Pending List';
                            image = LedgerBook;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Issue Pending List";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                        action("Pending Immigration List")
                        {
                            Caption = 'Pending Immigration List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Immigration list";
                            RunPageLink = "Student No" = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                        }
                        // action("Pending Housing Financial Accountability List")
                        // {
                        //     Caption = 'Pending Housing Financial Accountability List';
                        //     Image = DataEntry;
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Housing Fin Account List";
                        //     RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        // }
                        action("Pending Parking Sticker Assignment List")
                        {
                            Caption = 'Pending Parking Sticker Assignment List';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Parking Details List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                    }
                    group("Posted Applications ")
                    {
                        action("Approved/Rejected Housing Application")
                        {
                            Caption = 'Approved/Rejected Housing Application';
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Posted Housing Application";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Approved/Rejected Housing Waiver List")
                        {
                            Caption = 'Approved/Rejected Housing Waiver List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Wavier Approved List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Approved/Rejected Change Request")
                        {
                            Caption = 'Approved/Rejected Change Request';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve Reject Housing Change";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Approved/Rejected Vacate Request")
                        {
                            Caption = 'Approved/Rejected Vacate Request';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve Reject Housing Vacate";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        // action("Approved/Rejected Re-registration Request")
                        // {
                        //     Caption = 'Approved/Rejected Re-registration Request';
                        //     image = PostApplication;
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Approve Reject Re-Registration";
                        //     RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        // }
                        // action("Approved/Rejected Immigration List")
                        // {
                        //     Caption = 'Approved/Rejected Immigration List';
                        //     image = PostApplication;
                        //     ApplicationArea = Basic, Suite;
                        //     RunObject = Page "Immigration Approved list";
                        //     RunPageLink = "Student No" = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        // }
                        action("Assigned Parking Sticker List")
                        {
                            Caption = 'Assigned Parking Sticker List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Housing Parking Assigned List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Approved/Rejected Financial Accountability")
                        {
                            Caption = 'Approved/Rejected Financial Accountability';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve/Reject Fin Account";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Rejected Housing Issue list")
                        {
                            Caption = 'Rejected Housing Issue list';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Closed Housing Issue List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Resolved Housing Issue list")
                        {
                            Caption = 'Resolved Housing Issue list';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Housing Issue Accepted List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                    }

                }
                group("Bursar")
                {
                    Visible = BursarGroup;
                    action("Bursar Signoff Details")
                    {
                        Caption = '&Bursar Signoff Details';
                        Image = ViewDetails;
                        ApplicationArea = All;
                        // trigger OnAction()
                        // Var
                        //     BursarSingoffDetails: Page "Bursar Signoff Details";
                        // begin
                        //     BursarSingoffDetails.SetParameter(Rec.Term, Rec.Semester, Rec."Academic Year", Rec."No.");
                        //     BursarSingoffDetails.Run();
                        // end;

                    }
                    action("Customer Card")
                    {
                        Caption = 'Customer Card';
                        image = PostApplication;
                        Visible = Balance;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Card";
                        RunPageLink = "No." = FIELD("Original Student No.");

                    }
                    action("Ledger Entries")
                    {
                        Caption = 'Ledger Entries';
                        image = PostApplication;
                        Visible = Balance;
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Customer Ledger Entries";
                        RunPageLink = "Customer No." = FIELD("Original Student No.");
                        RunPageView = SORTING("Customer No.");
                        ShortCutKey = 'Ctrl+F7';
                    }
                    action("FERPA DetailB")
                    {
                        Caption = 'FERPA Details';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        trigger OnAction()
                        var
                            FerpaRec: Record "FERPA Details";
                            FerpaPag: Page "FERPA Details List";
                        begin
                            FerpaRec.Reset();
                            FerpaRec.SetCurrentKey("Created On");
                            FerpaRec.SetRange("Student No.", Rec."No.");
                            //If FerpaRec.FindLast() then begin
                            FerpaPag.SetTableView(FerpaRec);
                            FerpaPag.Run();
                            //end;
                        end;

                        // RunObject = Page "FERPA Details List";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }
                    // action("Student Legacy Ledger ")
                    // {
                    //     Caption = 'Student Legacy Ledger';
                    //     Image = Ledger;
                    //     ApplicationArea = All;
                    //     //Promoted = true;
                    //     //PromotedCategory = Category8;
                    //     RunObject = Page "SFAS Detail-CS";
                    //     RunPageLink = "Roll No." = FIELD("Enrollment No.");
                    // }

                    // Action("Student Legacy Ledgers")
                    // {
                    //     Caption = 'Student Legacy Ledger';
                    //     Image = List;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Studen Legacy Ledger";
                    //     RunPageLink = "Student Number" = Field("Original Student No.");
                    // }
                    // action("Student Housing Ledger")
                    // {
                    //     Caption = 'Student Housing Ledger';
                    //     image = PostApplication;
                    //     ApplicationArea = Basic, Suite;
                    //     RunObject = Page "Housing Ledger";
                    //     RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                    // }
                    action("OLR Stages")
                    {
                        Caption = 'OLR Stages';
                        Image = EntriesList;
                        ApplicationArea = All;
                        trigger OnAction()
                        var
                            StudentRegistrationRec: Record "Student Registration-CS";
                            StudentRegistrationlistPag: Page "Student Registration list";
                        begin
                            StudentRegistrationRec.Reset();
                            StudentRegistrationRec.SetCurrentKey("Created On");
                            StudentRegistrationRec.SetRange("Student No", Rec."No.");
                            If StudentRegistrationRec.FindLast() then begin
                                StudentRegistrationlistPag.SetTableView(StudentRegistrationRec);
                                StudentRegistrationlistPag.Run();
                            end;
                        end;
                        // RunObject = Page "Student Registration list";
                        // RunPageLink = "Student No" = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                    }
                    group(" Pending Applications")
                    {
                        action("Pending Financial Aid Application")
                        {
                            Caption = 'Pending Financial Aid Application';
                            image = PostApplication;
                            Visible = FinancialAid_GBoo;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                FinAIDRec: Record "Financial AID";
                                FinancialAidPag: Page "Financial AID Pending List";
                            begin
                                FinAIDRec.Reset();
                                FinAIDRec.SetCurrentKey("Created On");
                                FinAIDRec.SetRange("Student No.", Rec."No.");
                                If FinAIDRec.FindLast() then begin
                                    FinancialAidPag.SetTableView(FinAIDRec);
                                    FinancialAidPag.Run();
                                end;
                            end;
                            // RunObject = Page "Financial AID Pending List";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Pending Financial Aid Roster")
                        {
                            Caption = 'Pending Financial Aid Roster';
                            image = PostApplication;
                            Visible = FinancialAid_GBoo;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Financial Aid Roster";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Pending Payment Option Status")
                        {
                            Caption = 'Pending Payment Option Status';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Payment Plan List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Pending Withdrawal Approval List")
                        {
                            Caption = 'Pending Withdrawal Approval List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Withdrawal Approvals";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Pending Financial Accountability List")
                        {
                            Caption = 'Pending Financial Accountability List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Pending Financial Account";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Pending Wire Transfer List")
                        {
                            RunObject = Page "Details List-RTGS-CS";
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }

                    }
                    group("Discounts2")
                    {
                        Caption = 'Discounts';
                        action("Scholarship Details2")
                        {
                            Caption = 'Scholarship Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            RunPageLink = code = FIELD("Scholarship Source");

                        }
                        action("Grant Details2")
                        {
                            Caption = 'Grant Details 1';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            RunPageLink = Code = Field("Grant Code 1");

                        }
                        action("Grant Details3")
                        {
                            Caption = 'Grant Details 2';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            RunPageLink = Code = Field("Grant Code 2");

                        }
                        action("Grant Details4")
                        {
                            Caption = 'Grant Details 3';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            RunPageLink = Code = Field("Grant Code 3");
                        }
                        action("Waiver Details2")
                        {
                            Caption = 'Waiver Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Scholar. Source L-CS";
                            //RunPageLink = "Student No." = FIELD("No.");

                        }

                    }
                    group(" Posted Applications ")
                    {
                        action("Posted Financial Aid Details")
                        {
                            Caption = 'Posted Financial Aid Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            Visible = FinancialAid_GBoo;
                            RunObject = Page "FinancialAIDApprovRejectList";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Financial Aid Roster Approved/Rejected List")
                        {
                            Caption = 'Financial Aid Roster Approved/Rejected List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            Visible = FinancialAid_GBoo;
                            RunObject = Page "FAid Roster Approved/Rejected";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Payment Option Approved/Rejected List")
                        {
                            Caption = 'Payment Option Approved/Rejected List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Payment Plan Approved/Rejected";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Posted Housing Application")
                        {
                            Caption = 'Posted Housing Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            // RunObject = Page "Posted Housing Application";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                            trigger OnAction()
                            Var
                                HousingApplication_lRec: Record "Housing Application";
                                PostedHousingApplication_lPag: Page "Posted Housing Application";
                            Begin
                                Clear(PostedHousingApplication_lPag);
                                HousingApplication_lRec.Reset();
                                HousingApplication_lRec.SetRange("Student No.", Rec."No.");
                                PostedHousingApplication_lPag.SetTableView(HousingApplication_lRec);
                                PostedHousingApplication_lPag.Run();

                            End;

                        }
                        action("Approved Withdrawal Application Form")
                        {
                            Caption = 'Approved Withdrawal Application Form';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Approved Course Withdrawal";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Posted Housing Waiver Application ")
                        {
                            Caption = 'Posted Housing Waiver Application';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            // RunObject = Page "Housing Wavier Approved List";
                            // RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);
                            trigger OnAction()
                            Var
                                Optout_lRec: Record "Opt Out";
                                HousingWaiverApprovedList_lPag: Page "Housing Wavier Approved List";
                            begin
                                Clear(HousingWaiverApprovedList_lPag);
                                Optout_lRec.Reset();
                                Optout_lRec.SetRange("Student No.", Rec."No.");
                                HousingWaiverApprovedList_lPag.SetTableView(Optout_lRec);
                                HousingWaiverApprovedList_lPag.Run();
                            end;
                        }
                        action("Approved Financial Accountability List")
                        {
                            Caption = 'Approved Financial Accountability List';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Approve/Reject Fin Account";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Student Holds")
                        {
                            Caption = 'Student Holds';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Student Wise Hold List";
                            RunPageLink = "Student No." = FIELD("No.");

                        }
                        // action("Approved/Rejected Wire Transfer List")
                        // {
                        //     RunObject = Page "Approved Rejected RTGS List";
                        //     image = PostApplication;
                        //     ApplicationArea = Basic, Suite;
                        // }

                    }
                    group("Discounts")
                    {
                        action("Scholarship Details")
                        {
                            Caption = 'Scholarship Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            //RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Grant Details")
                        {
                            Caption = 'Grant Details';
                            image = PostApplication;

                            ApplicationArea = Basic, Suite;
                            RunObject = Page "Scholar. Source L-CS";
                            // RunPageLink = "Student No." = FIELD("No.");

                        }
                        action("Waiver Details")
                        {
                            Caption = 'Waiver Details';
                            image = PostApplication;
                            ApplicationArea = Basic, Suite;

                            RunObject = Page "Scholar. Source L-CS";
                            //RunPageLink = "Student No." = FIELD("No.");

                        }

                    }

                    group("Reports")
                    {
                        action("Student Fee Component Details")
                        {
                            Caption = 'Student Fee Component Details';
                            image = GanttChart;
                            //Promoted = true;
                            //PromotedCategory = Category8;
                            ApplicationArea = All;
                            // trigger OnAction()
                            // var
                            //     StudentFeeComp: Report "Finance Fee";
                            // begin
                            //     StudentFeeComp.VariablePassing("Global Dimension 1 Code", "Academic Year", Semester, "Enrollment No.");
                            //     StudentFeeComp.Run();
                            // end;
                        }
                        action("Semester Fee Calculation")
                        {
                            Caption = 'Semester Fee Calculation';
                            Image = Calculate;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category8;
                            // trigger OnAction()
                            // var
                            //     StudentFeeDetailTemp: Page "Student Fee Details";
                            // begin
                            //     StudentFeeDetailTemp.VariablePassing("No.");
                            //     StudentFeeDetailTemp.RunModal();
                            // end;
                        }
                    }
                }
                group("Financial Aid")
                {
                    Visible = FinancialAid1;
                    action("Financial Aid Sign off")
                    {
                        Caption = '&Financial Aid Sign Off';
                        Image = SignUp;
                        ApplicationArea = All;
                        Visible = FinancialAid_GBoo;
                        //Promoted = true;
                        //PromotedCategory = Category9;
                        // trigger OnAction()
                        // begin
                        //     FinancialAidSignoff(Rec);
                        // end;
                    }
                    group("SFP Update")

                    {
                        action("Student Initiation")
                        {
                            Image = Close;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category5;
                            // trigger OnAction()
                            // Var
                            //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                            //     StudentCount: Integer;
                            // begin
                            //     CurrPage.SetSelectionFilter(StudentMasterCS);
                            //     StudentCount := StudentMasterCS.Count();
                            //     IF StudentCount > 1 then begin
                            //         IF CONFIRM(Text0021Lbl, FALSE) THEN BEGIN
                            //             IF StudentMasterCS.FindFirst() Then
                            //                 repeat
                            //                     WebServicesFunctionsCod.SAFI_Student_InitiationFunction(StudentMasterCS."No.");
                            //                 until StudentMasterCS.next() = 0;
                            //             Message(Text0023Lbl);
                            //             CurrPage.Update();
                            //         end else
                            //             exit;
                            //     end else
                            //         IF CONFIRM(Text0022Lbl, FALSE, Rec."No.") THEN BEGIN
                            //             WebServicesFunctionsCod.SAFI_Student_InitiationFunction(Rec."No.");
                            //             Message(Text0024Lbl, Rec."No.");
                            //             CurrPage.Update();
                            //         end else
                            //             exit;
                            // end;
                        }
                        action("SAFI Event")
                        {
                            Image = Close;
                            ApplicationArea = All;
                            // Promoted = true;
                            // PromotedCategory = Category5;
                            //     trigger OnAction()
                            //     Var
                            //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                            //         StudentCount: Integer;
                            //     begin
                            //         CurrPage.SetSelectionFilter(StudentMasterCS);
                            //         StudentCount := StudentMasterCS.Count();
                            //         IF StudentCount > 1 then begin
                            //             IF CONFIRM(Text0025Lbl, FALSE) THEN BEGIN
                            //                 IF StudentMasterCS.FindFirst() Then
                            //                     repeat
                            //                         WebServicesFunctionsCod.SAFI_Student_EventFunction(StudentMasterCS."No.", StudentMasterCS.Semester, StudentMasterCS."Original Student No.");
                            //                     until StudentMasterCS.next() = 0;
                            //                 Message(Text0027Lbl);
                            //                 CurrPage.Update();
                            //             end else
                            //                 exit;
                            //         end else
                            //             IF CONFIRM(Text0026Lbl, FALSE, Rec."No.") THEN BEGIN
                            //                 WebServicesFunctionsCod.SAFI_Student_EventFunction(Rec."No.", Rec.Semester, Rec."Original Student No.");
                            //                 Message(Text0028Lbl, Rec."No.");
                            //                 CurrPage.Update();
                            //             end else
                            //                 exit;
                            //     end;
                            // }
                            // action("SAFI Event Live")
                            // {
                            //     Image = Close;
                            //     ApplicationArea = All;
                            //     Visible = False;
                            //     // Promoted = true;
                            //     // PromotedCategory = Category5;
                            //     trigger OnAction()
                            //     Var
                            //         WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
                            //         StudentCount: Integer;
                            //     begin
                            //         CurrPage.SetSelectionFilter(StudentMasterCS);
                            //         StudentCount := StudentMasterCS.Count();
                            //         IF StudentCount > 1 then begin
                            //             IF CONFIRM(Text0025Lbl, FALSE) THEN BEGIN
                            //                 IF StudentMasterCS.FindFirst() Then
                            //                     repeat
                            //                     // WebServicesFunctionsCod.SAFI_Student_EventFunctionLive(StudentMasterCS."No.", StudentMasterCS.Semester);
                            //                     until StudentMasterCS.next() = 0;
                            //                 Message(Text0027Lbl);
                            //                 CurrPage.Update();
                            //             end else
                            //                 exit;
                            //         end else
                            //             IF CONFIRM(Text0026Lbl, FALSE, Rec."No.") THEN BEGIN
                            //                 // WebServicesFunctionsCod.SAFI_Student_EventFunctionLive(Rec."No.", Rec.Semester);
                            //                 Message(Text0028Lbl, Rec."No.");
                            //                 CurrPage.Update();
                            //             end else
                            //                 exit;
                            //     end;
                        }
                    }
                    Action("Student Legacy Ledger")
                    {
                        Caption = 'Student Legacy Ledger';
                        Image = List;
                        ApplicationArea = All;
                        // RunObject = Page "Studen Legacy Ledger";
                        // RunPageLink = "Student Number" = Field("Original Student No.");
                    }
                    Action("Rotation Ledger Entry")
                    {
                        Caption = 'Rotation Ledger Entry';
                        Image = List;
                        ApplicationArea = All;
                        Visible = false;
                        //Moved to Academics
                        RunObject = Page "Roster Ledger Entries";
                        // RunPageLink = "Student ID" = field("Original Student No.");

                    }
                    action("List of Rotations FA")
                    {
                        Caption = 'List of Rotation(s)';
                        Image = EntriesList;
                        ApplicationArea = All;
                        // RunObject = Page "Roster Scheduling Lines";
                        // RunPageLink = "Student No." = field("No.");
                        // RunPageView = sorting("Start Date", "Rotation ID") Order(ascending);
                        trigger OnAction()
                        var
                            RSL: Record "Roster Scheduling Line";
                        begin
                            RSL.Reset();
                            RSL.SetCurrentKey("Student No.", "Start Date");
                            RSL.FilterGroup(2);
                            RSL.SetRange("Student No.", Rec."No.");
                            //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                            RSL.FilterGroup(2);
                            Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                        end;
                    }
                    action("FERPA DetailF")
                    {
                        Caption = 'FERPA Details';
                        Image = DataEntry;
                        ApplicationArea = Basic, Suite;
                        trigger OnAction()
                        var
                            FerpaRec: Record "FERPA Details";
                            FerpaPag: Page "FERPA Details List";
                        begin
                            FerpaRec.Reset();
                            FerpaRec.SetCurrentKey("Created On");
                            FerpaRec.SetRange("Student No.", Rec."No.");
                            //If FerpaRec.FindLast() then begin
                            FerpaPag.SetTableView(FerpaRec);
                            FerpaPag.Run();
                            //end;
                        end;

                        // RunObject = Page "FERPA Details List";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("&Student Subjet Fi")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;
                        Visible = false;
                        //Moved to Academics
                        RunObject = Page "Subject Student-CS";
                        // RunPageLink = "Original student No." = field("Original Student No.");

                    }
                    action("E-Mail Notification ListFA")
                    {
                        Caption = 'E-Mail Notification List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Trigger OnAction()
                        var
                            EmailnotificationRec: Record "Email Notification";
                            EmailNotificationPage: Page "E-Mail Notification List";
                        Begin
                            Clear(EmailNotificationPage);
                            EmailnotificationRec.Reset();
                            EmailnotificationRec.Setfilter(ReceiverId, Rec."Original Student No." + '*');
                            EmailnotificationRec.SetFilter(Subject, '*AUA Login Credentials*');
                            EmailNotificationPage.SetTableView(EmailnotificationRec);
                            EmailNotificationPage.Run();
                        End;
                    }

                    group("Student TranscriptsA1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptAsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptAsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptAsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsA1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptAsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptAsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsA1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptAsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsARPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }

                    group("Academics")
                    {

                        action("Semester GPA Details_")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            Visible = false;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                // SemesterGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Details_")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Visible = false;
                            //Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                // YearGPATemp.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Stud Attendance Detail")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Visible = false;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Stud Promotion List")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            Visible = false;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        Action("Rotation Ledger Entry ")
                        {
                            Caption = 'Rotation Ledger Entry';
                            Image = List;
                            ApplicationArea = All;
                            RunObject = Page "Roster Ledger Entries";
                            RunPageLink = "Student ID" = field("Original Student No.");

                        }
                        action("&Student Subjet Fi ")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;
                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "Original student No." = field("Original Student No.");

                        }
                        action("Inter Log Entry")
                        {
                            Caption = 'Interaction Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No.");
                        }
                    }
                    group("Pending Application")
                    {
                        action("Pending Financial Aid Details")
                        {
                            Caption = 'Pending Financial Aid Details';
                            Visible = FinancialAid_GBoo;
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "Financial AID Pending List";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);


                        }
                        action("Pending Semester Warning Application")
                        {
                            Caption = 'Pending Semester Warning Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                        action("Pending Appeal Application")
                        {
                            Caption = 'Pending Appeal Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }

                    }
                    group("Posted Application")
                    {
                        action("Posted Financial Aid Details_")
                        {
                            Caption = 'Posted Financial Aid Details';
                            Visible = FinancialAid_GBoo;
                            image = PostApplication;
                            ApplicationArea = All;
                            RunObject = Page "FinancialAIDApprovRejectList";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                        }
                        action("Posted Semester Warning Application")
                        {
                            Caption = 'Posted Semester Warning Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                        action("Posted Appeal Application")
                        {
                            Caption = 'Posted Appeal Application';
                            image = PostApplication;
                            ApplicationArea = All;


                        }
                    }
                    group("Legacy Data")
                    {
                        action("FA Refund Master")
                        {
                            Caption = 'FA Refund Master';
                            image = Account;
                            ApplicationArea = All;
                            // RunObject = page "FA Refund Master";
                            // RunPageLink = "Student No." = FIELD("No."), AdEnrollID = field("Enrollment No.");
                        }
                        action("Inter Log Entry1")
                        {
                            Caption = 'Inter Log Entry';
                            image = Entries;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }

                }
                group("EED Pre-Clinical")
                {
                    Visible = EEDBasicSciGroup;
                    action("Student EED Pre-Clinical Advisor")
                    {
                        Caption = 'Student EED Pre-Clinical Advisor';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Pending Appointment List_")
                    {
                        Caption = 'Pending Appointment List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Meeting Updates_")
                    {
                        Caption = 'Meeting Updates';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Medical Scholar Program Application")
                    {
                        Caption = 'Medical Scholar Program Application';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    // action("Internal Exam Published List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = EntriesList;
                    //     RunObject = page "Internal Exam Published List";//50984
                    // }
                    // action("External Exam Published List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = EntriesList;
                    //     RunObject = page "External Exam Published List";//50985
                    // }
                    // action("Internal Exam List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = List;
                    //     // RunObject = page "Student Subject Exam List";//50956
                    //     // RunPageLink = "Original Student No." = Field("Original Student No."), "Level Description" = filter("Internal Exam Component");
                    //     RunPageMode = View;

                    // }
                    // action("External Exam List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = List;
                    //     RunObject = page "Student Subject Exam List";//50956
                    //     RunPageLink = "Original Student No." = Field("Original Student No."), "Level Description" = filter("External Examination");
                    //     RunPageMode = View;
                    // }
                    // action("Student Subject Exams List EEDBS")
                    // {
                    //     Caption = 'Student Subject Exams';
                    //     Image = List;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Student Subject Exam List";
                    //     RunPageLink = "ORiginal student No." = field("Original Student No.");

                    // }
                    // action("Sudent Subject Grade Book List")
                    // {
                    //     ApplicationArea = Basic, Suite;
                    //     Image = EntriesList;
                    //     RunObject = Page StudentSubjectGradeBookList;
                    //     RunPageLink = "Student No." = FIELD("No.");
                    // }
                    action("&Student Subjet EEDBS")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;

                        RunObject = Page "Subject Student-CS";
                        RunPageLink = "ORiginal student No." = field("Original Student No.");

                    }
                    // action("Enrolment History List EEDBS")
                    // {
                    //     Caption = 'Enrolment History List';
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    //     trigger OnAction()
                    //     var
                    //         EnrollmentHistoryRec: Record "Enrollment History";
                    //         EnrollmentHistoryPag: Page "Enrollment History List";
                    //     begin
                    //         EnrollmentHistoryRec.Reset();
                    //         EnrollmentHistoryRec.Setrange("Student No.", Rec."No.");
                    //         Clear(EnrollmentHistoryPag);
                    //         EnrollmentHistoryPag.SetTableView(EnrollmentHistoryRec);
                    //         if Rec."Entry From Salesforce" then begin
                    //             EnrollmentHistoryPag.Editable := false;
                    //             EnrollmentHistoryPag.Run();
                    //         end else begin
                    //             EnrollmentHistoryPag.Editable := true;
                    //             EnrollmentHistoryPag.Run();
                    //         end;
                    //     end;
                    // }
                    // action("Student Educational Qualification details EEDBS")
                    // {
                    //     Caption = 'Student Educational Qualification';
                    //     image = GanttChart;
                    //     ApplicationArea = All;
                    //     trigger OnAction()
                    //     var
                    //         QualifyingDetailsRec: Record "Qualifying Detail Stud-CS";
                    //         QualifyingDetailsPag: Page "Qualifying Detail Stud List-CS";
                    //     begin
                    //         QualifyingDetailsRec.Reset();
                    //         QualifyingDetailsRec.Setrange("Student No.", Rec."No.");
                    //         Clear(QualifyingDetailsPag);
                    //         QualifyingDetailsPag.SetTableView(QualifyingDetailsRec);
                    //         if Rec."Entry From Salesforce" then begin
                    //             QualifyingDetailsPag.Editable := false;
                    //             QualifyingDetailsPag.Run();
                    //         end else begin
                    //             QualifyingDetailsPag.Editable := true;
                    //             QualifyingDetailsPag.Run();
                    //         end;
                    //     end;
                    // }
                    // Action("Student Notes")
                    // {
                    //     ApplicationArea = all;
                    //     Image = EntriesList;
                    //     RunObject = Page "Student Notes List";
                    //     RunPageLink = "Student No." = FIELD("No.");
                    // }
                    group("Student TranscriptsEEDPCPrint1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsEEDPCPrint6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        // Visible = false;

                        action("Unofficial TranscriptsEEDPCPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }


                    group("Academics ")
                    {
                        Visible = false;
                        action("Sem GPA Details")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail-")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Stud Attendance Details_")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("Stud Promotion List_")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                    }
                    group("Legacy Data3")
                    {
                        Caption = 'Legacy Data';
                        Visible = false;
                        action("Inter Log Entry3")
                        {
                            Caption = 'Inter Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }

                }

                group("EED Clinical")
                {
                    Visible = EEDClinicalGroup;
                    action("Student Clinical Advisor")
                    {
                        Caption = 'Student Clinical Advisor';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Pending Appointment List")
                    {
                        Caption = 'Pending Appointment List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Meeting Updates")
                    {
                        Caption = 'Meeting Updates';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    // action("Pending Advising Request")
                    // {
                    //     Caption = 'Pending Advising Request';
                    //     image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = page "Advising Request List";
                    //     RunPageLink = "Student No." = field("No.");


                    // }
                    // action("Approved Advising Request")
                    // {
                    //     Caption = 'Approved Advising Request';
                    //     image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "App. Resch. Advs. Request List";
                    //     RunPageLink = "Student No." = field("No.");

                    // }
                    // action("Completed Advising Request")
                    // {
                    //     Caption = 'Completed Advising Request';
                    //     image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Rejc. Comp. Advis. Req. List";
                    //     RunPageLink = "Student No." = field("No.");
                    // }

                    group(" Academics")
                    {
                        action("Sem GPA Details_")
                        {
                            Caption = 'Semester GPA Details';
                            Image = Calculate;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                SemesterGPATemp: Page "Semester GPA";
                            begin
                                SemesterGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                SemesterGPATemp.RunModal();
                            end;
                        }
                        action("Year GPA Detail_")
                        {
                            Caption = 'Year GPA Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            //Promoted = true;
                            //PromotedCategory = Category9;
                            trigger OnAction()
                            var
                                YearGPATemp: Page "Year GPA";
                            begin
                                YearGPATemp.VariablePassing(Rec."No.", Rec."Course Code", Rec."Global Dimension 1 Code");
                                YearGPATemp.RunModal();
                            end;
                        }
                        action("Studend Attendance Details_")
                        {
                            Caption = 'Student Attendance Details';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // Promoted = true;
                            //PromotedCategory = Category9;
                            RunObject = Page "Attendance Student Line-CS";
                            RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                        }
                        action("Student Promotion List_")
                        {
                            Caption = 'Student Promotion List';
                            Image = EntriesList;
                            ApplicationArea = All;
                            RunObject = Page "Promotion Student List-CS";
                            RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                        }
                        action("&Student Subjet EEDC")
                        {
                            Caption = '&Student Subject';
                            image = GanttChart;
                            ApplicationArea = All;

                            RunObject = Page "Subject Student-CS";
                            RunPageLink = "ORiginal student No." = field("Original Student No.");

                        }
                        action("Student Subject Exams List EEDC")
                        {
                            Caption = 'Student Subject Exams';
                            Image = List;
                            ApplicationArea = All;
                            // RunObject = Page "Student Subject Exam List";
                            // RunPageLink = "ORiginal student No." = field("Original Student No.");

                        }
                        action("FERPA Details EEDC")
                        {
                            Caption = 'FERPA Details';
                            Image = DataEntry;
                            ApplicationArea = Basic, Suite;
                            trigger OnAction()
                            var
                                FerpaRec: Record "FERPA Details";
                                FerpaPag: Page "FERPA Details List";
                            begin
                                FerpaRec.Reset();
                                FerpaRec.SetCurrentKey("Created On");
                                FerpaRec.SetRange("Student No.", Rec."No.");
                                FerpaPag.SetTableView(FerpaRec);
                                FerpaPag.Run();
                            end;
                        }

                        action("Roster Ledger Entries EEDC")
                        {
                            Caption = 'Roster Ledger Entries';
                            Image = LedgerEntries;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                RLE: Record "Roster Ledger Entry";
                            begin
                                RLE.Reset();
                                RLE.SetCurrentKey("Start Date");
                                RLE.Ascending(false);
                                RLE.FilterGroup(2);
                                RLE.SetRange("Student ID", Rec."No.");
                                RLE.FilterGroup(2);
                                Page.RunModal(Page::"Roster Ledger Entries", RLE)
                            end;
                        }

                        action("List of Rotations EEDC")
                        {
                            Caption = 'List of Rotation(s)';
                            Image = EntriesList;
                            ApplicationArea = All;
                            // RunObject = Page "Roster Scheduling Lines";
                            // RunPageLink = "Student No." = field("No.");
                            // RunPageView = sorting("Start Date", "Rotation ID") Order(ascending);
                            trigger OnAction()
                            var
                                RSL: Record "Roster Scheduling Line";
                            begin
                                RSL.Reset();
                                RSL.SetCurrentKey("Student No.", "Start Date");
                                RSL.FilterGroup(2);
                                RSL.SetRange("Student No.", Rec."No.");
                                //RSL.SetFilter("Clerkship Type", '%1', RSL."Clerkship Type"::Core);
                                RSL.FilterGroup(2);
                                Page.RunModal(Page::"Roster Scheduling Lines", RSL)
                            end;
                        }

                        action("Student Residency Status EEDC")
                        {
                            Caption = 'Student Residency Status';
                            image = PostApplication;
                            ApplicationArea = All;
                            // RunObject = Page "Residency List";
                            // RunPageLink = "Student No." = field("No.");
                        }
                    }
                    group("Legacy Data2")
                    {
                        Caption = 'Legacy Data';
                        action("Inter Log Entry2")
                        {
                            Caption = 'Inter Log Entry';
                            image = Account;
                            ApplicationArea = All;
                            RunObject = page "Interaction Log Entries";
                            RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        }
                    }
                    group("Student TranscriptsEEDC Print1")
                    {
                        Caption = 'Student Transcripts Print 1';

                        action("Unofficial TranscriptsEEDCPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsEEDCPrint2")
                    {
                        Caption = 'Student Transcripts Print 2';

                        action("Unofficial TranscriptsEEDCPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsEEDCPrint3")
                    {
                        Caption = 'Student Transcripts Print 3';

                        action("Unofficial TranscriptsEEDCPrint 3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptBsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsB1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptBsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptBsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }

                }
                group("Graduate Affairs")
                {
                    Visible = GraduateAffairsGroup;

                    // action("Pending MSPE Application")
                    // {
                    //     Caption = 'Pending MSPE Application';
                    //     image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Pending MSPE Application List";
                    //     RunPageLink = "Student No" = field("No.");
                    // }
                    // Action("In Review MSPE Application")
                    // {
                    //     Caption = 'In Review MSPE Application';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "In-Review MSPE App List";
                    //     RunPageLink = "Student No" = field("No.");
                    // }
                    // Action("Review Required MSPE Application")
                    // {
                    //     Caption = 'Review Required MSPE Application';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Review Required MSPE App List";
                    //     RunPageLink = "Student No" = field("No.");
                    // }
                    // Action("Completed MSPE Application")
                    // {
                    //     Caption = 'Completed MSPE Application';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Completed MSPE App List";
                    //     RunPageLink = "Student No" = field("No.");
                    // }

                    // action("Student Residency Status")
                    // {
                    //     Caption = 'Student Residency Status';
                    //     image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Residency List";
                    //     RunPageLink = "Student No." = field("No.");
                    // }

                    action("Residency Notes")
                    {
                        ApplicationArea = All;
                        Caption = 'Residency Notes';
                        Image = Notes;
                        //Promoted = true;
                        //PromotedCategory = Process;
                        //PromotedOnly = true;
                        trigger OnAction()
                        var
                            InteractionTemplate: Record "Interaction Template";
                            InteractionGroup: Record "Interaction Group";
                            InterLogEntryCommentLine: Record "Interaction Log Entry";
                        begin
                            //TestField("No.");
                            InteractionTemplate.Reset();
                            InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                            IF not InteractionTemplate.FindLast() then
                                Error('Interaction Template not found for Residency Type.');

                            InteractionGroup.Reset();
                            InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Note");
                            IF not InteractionGroup.FindLast() then
                                Error('Interaction Group not found for Residency Type.');

                            InterLogEntryCommentLine.Reset();
                            //InterLogEntryCommentLine.SetRange("Source No.", resi);
                            InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                            InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                            InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Original Student No.");
                            InterLogEntryCommentLine.SetRange("Student No. Filter", Rec."No.");
                            // Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                        end;
                    }

                    action("Residency Employment Notes")
                    {
                        ApplicationArea = All;
                        Caption = 'Residency Employment Notes';
                        Image = Notes;
                        //Promoted = true;
                        //PromotedCategory = Process;
                        //PromotedOnly = true;
                        trigger OnAction()
                        var
                            InteractionTemplate: Record "Interaction Template";
                            InteractionGroup: Record "Interaction Group";
                            InterLogEntryCommentLine: Record "Interaction Log Entry";
                        begin
                            // TestField("Student No.");
                            InteractionTemplate.Reset();
                            InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                            IF not InteractionTemplate.FindLast() then
                                Error('Interaction Template not found for Residency Type.');

                            InteractionGroup.Reset();
                            InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Employement Note");
                            IF not InteractionGroup.FindLast() then
                                Error('Interaction Group not found for Residency Employement Note Type.');

                            InterLogEntryCommentLine.Reset();
                            //InterLogEntryCommentLine.SetRange("Source No.", "Residency No.");
                            InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                            InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                            InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Original Student No.");
                            InterLogEntryCommentLine.SetRange("Student No. Filter", Rec."No.");
                            // Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                        end;
                    }
                    action("License Tracking")
                    {
                        Caption = 'License Tracking';
                        Image = PostApplication;
                        ApplicationArea = All;
                        // RunObject = Page "License Tracking";
                        // RunPageLink = "Student No." = field("No.");
                    }
                    action("&Student Sub")
                    {
                        Caption = '&Student Subject';
                        image = List;
                        ApplicationArea = All;

                        RunObject = Page "Subject Student-CS";
                        RunPageLink = "Student No." = field("No.");

                    }
                    // Action("Student Rotation Audit")
                    // {
                    //     Caption = 'Student Rotation Audit';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = page "Students Rotation Audit";
                    //     RunPageLink = "Original Student No." = Field("Original Student No.");
                    // }


                    Action("Student Rotation Audit")
                    {
                        Caption = 'Student Rotation Audit';
                        Image = PostApplication;
                        ApplicationArea = All;
                        // RunObject = page "Std Rotation Audit View";
                        // RunPageLink = "Original Student No." = Field("Original Student No.");
                    }


                    Action("&Clerkship Assessment")
                    {
                        Caption = 'Clerkship Assessment';
                        Image = PostApplication;
                        ApplicationArea = All;
                        RunObject = page "Published Clerkship Assessment";
                        RunPageLink = "Student No." = Field("No.");
                    }

                    Action("Student Subject Exam")
                    {
                        Caption = 'Student Subject Exam';
                        Image = PostApplication;
                        ApplicationArea = All;
                        // RunObject = page "Student Subject Exam List";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }
                    action("CCSE Score_1")
                    {
                        caption = 'CCSE Score';
                        ApplicationArea = All;
                        Image = List;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        // RunObject = page "Student Subject Exam List";
                        // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSE);
                    }
                    action("CCSSE Score_1 ")
                    {
                        caption = 'CCSSE Score';
                        ApplicationArea = All;
                        Image = List;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        // PromotedCategory = Process;
                        // RunObject = page "Student Subject Exam List";
                        // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSSE);
                    }
                    action("CBSE Score_1")
                    {
                        Caption = 'CBSE Score';
                        ApplicationArea = All;
                        Image = List;
                        // Promoted = true;
                        // PromotedOnly = true;
                        // PromotedIsBig = true;
                        //PromotedCategory = Process;
                        // RunObject = page "Student Subject Exam List";
                        // RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CBSE);
                    }
                    Action("USMLE Scores")
                    {
                        Caption = 'USMLE Scores';
                        Image = PostApplication;
                        ApplicationArea = All;
                        // RunObject = page "Student Subject Exam List";
                        // RunPageLink = "Original Student No." = Field("Original Student No."), "Score Type" = filter("STEP 1" | "STEP 2 CS" | "STEP 2 CK");
                    }

                    group("Student TranscriptsB1Print1")
                    {
                        Caption = 'Student Transcripts Print 1';
                        action("Official TranscriptBsPrint1")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint1")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsB1Print2")
                    {
                        Caption = 'Student Transcripts Print 2';
                        action("Official TranscriptBsPrint2")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts1(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint2")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts1(Rec);
                            end;
                        }
                    }
                    group("Student TranscriptsB1Print3")
                    {
                        Caption = 'Student Transcripts Print 3';
                        action("Official TranscriptBsPrint3")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts2(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsBRPrint3")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts2(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsC1Print4")
                    {
                        Caption = 'Student Transcripts Print 4';
                        action("Official TranscriptCsPrint4")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts3(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint4")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts3(Rec);
                            end;
                        }
                    }

                    group("Student TranscriptsC1Print5")
                    {
                        Caption = 'Student Transcripts Print 5';
                        action("Official TranscriptCsPrint5")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts4(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint5")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts4(Rec);
                            end;

                        }
                    }

                    group("Student TranscriptsC1Print6")
                    {
                        Caption = 'Student Transcripts Print 6';
                        action("Official TranscriptCsPrint6")
                        {
                            Caption = 'Official Transcript';
                            Image = PrintReport;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            Begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.OfficialTranscripts5(Rec);
                            End;
                        }
                        action("Unofficial TranscriptsCRPrint6")
                        {
                            Caption = 'Unofficial Transcript';
                            Image = PrintReport;
                            ApplicationArea = All;
                            trigger OnAction()
                            var
                                StudentStatusCU: Codeunit "Student Status Mangement";
                            begin
                                StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                StudentStatus.Status::Deposited] then
                                    Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                Clear(StudentStatusCU);
                                StudentStatusCU.UnOfficialTranscripts5(Rec);
                            end;
                        }
                    }
                    /*
                    Action("Roster Scheduling")
                    {
                        Caption = 'Roster Scheduling';
                        Image = PostApplication;
                        ApplicationArea = All;
                        RunObject = page "Roster Scheduling Lines";
                        RunPageLink = "Student No." = field("No.");
                    }
                    
                    action("Core Rotation Evaluation")
                    {
                        Caption = 'Core Rotation Evaluation';
                        Image = POstApplication;
                        ApplicationArea = All;
                        Runobject = Page "Subject Student-CS";
                        RunPageLink = "Student No." = field("No.");
                    }

                */

                    action("Match List")
                    {
                        Caption = 'Match List';
                        image = PostApplication;
                        ApplicationArea = All;
                    }
                    action("Licence Details")
                    {
                        Caption = 'Licence Details';
                        Image = Calculate;
                        ApplicationArea = All;

                    }
                    action("Student Promotion List-2")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                    }
                    /*
                    action("Core Rotation")
                    {
                        Caption = 'Core Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Roster Scheduling Subpage";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"),
                                  "Clerkship Type" = filter(Core);
                    }
                    action("Elective Rotation")
                    {
                        Caption = 'Elective Rotation';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Roster Scheduling Subpage";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"),
                                  "Clerkship Type" = filter(Elective);

                    }
                    */
                }

                group("Examination")
                {
                    Visible = ExaminationGroup;
                    action("Student Promotion List2")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                    }
                    action("Student Grade Details")
                    {
                        Caption = 'Student Grade Details';
                        image = PostApplication;
                        ApplicationArea = All;

                    }
                    action("Internal Exam Schedule")
                    {
                        Caption = 'Internal Exam Schedule';
                        image = PostApplication;
                        ApplicationArea = All;

                    }

                    action("Internal Exam Scores")
                    {
                        Caption = 'Internal Exam Scores';
                        Image = Calculate;
                        ApplicationArea = All;

                    }
                    action("Pending Make-up Application")
                    {
                        Caption = 'Pending Make-up Application';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "MakeUp Pending Approval";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);

                    }
                    action("Posted Make-up Application")
                    {
                        Caption = 'Posted Make-up Application';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "MakeUp Approved List";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year"), Term = Field(Term);


                    }
                    action("External Exam Schedule")
                    {
                        Caption = 'External Exam Schedule';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("External Exam Scores")
                    {
                        Caption = 'External Exam Scores';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("Student Attendance")
                    {
                        Caption = 'Student Attendance Details';
                        Image = EntriesList;
                        ApplicationArea = All;

                        RunObject = Page "Attendance Student Line-CS";
                        RunPageLink = "Student No." = FIELD("No."), Semester = field(Semester), "Academic Year" = Field("Academic Year");

                    }
                    action("Admit Card")
                    {
                        Caption = 'Admit Card';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("Final Exam Scores")
                    {
                        Caption = 'Final Exam Scores';
                        Image = EntriesList;
                        ApplicationArea = All;


                    }
                    action("USMLE Change Log")
                    {
                        Caption = 'USMLE Change Log';
                        Image = OpportunitiesList;
                        // RunObject = page "USMLE Change Log Entry List";
                        // RunPageLink = "Student ID" = field("No.");
                    }

                }
                group("Graduation ")
                {
                    Visible = GraduationGroup;


                    action("Application for Transcript/Certificate")
                    {
                        Caption = 'Application for Transcript/Certificate';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Degree Audit Document List")
                    {
                        Caption = 'Degree Audit Document List';
                        image = PostApplication;
                        ApplicationArea = All;


                    }
                    action("Student Promotion List-")
                    {
                        Caption = 'Student Promotion List';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page "Promotion Student List-CS";
                        RunPageLink = "Course" = FIELD("Course Code"), Semester = field(Semester), "Academic Year" = Field("Academic Year");
                    }

                    action("Course Degree Lists")
                    {
                        ApplicationArea = All;
                        Caption = 'Course Degree List';
                        Image = EntriesList;
                        // trigger OnAction()
                        // var
                        //     TempCourseDegreeList: Page "Temp Course Degree List";
                        // begin
                        //     TempCourseDegreeList.VariablePassing("No.", "Course Code", "Global Dimension 1 Code");
                        //     TempCourseDegreeList.RunModal();
                        // end;
                    }
                    action("Calc. Estimated Graduation Date")
                    {
                        Caption = 'Calc. Estimated Graduation Date';
                        Image = EntriesList;
                        ApplicationArea = All;

                        trigger OnAction()
                        var
                            ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                        begin
                            ClinicalBaseAppSubscribe.SemesterProgression(Rec, true);
                            Message('Estimated Graduation Date calculated successfully.');
                        end;
                    }
                    action("Student timelne")
                    {
                        Caption = 'Student timeline';
                        Image = EntriesList;
                        ApplicationArea = All;
                        // RunObject = Page "Student Time Line";
                        // RunPageLink = "Student No." = FIELD("No.");
                    }

                    action("Student GPA")
                    {
                        Caption = 'Student GPA';
                        Image = EntriesList;
                        ApplicationArea = All;
                        RunObject = Page StudentGPACalculation;
                        RunPageLink = "No." = FIELD("No.");
                    }
                    // action("CCSE Score_3")
                    // {
                    //     caption = 'CCSE Score';
                    //     ApplicationArea = All;
                    //     Image = List;
                    //     RunObject = page "Student Subject Exam List";
                    //     RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSE);
                    // }
                    // action("CCSSE Score_3")
                    // {
                    //     caption = 'CCSSE Score';
                    //     ApplicationArea = All;
                    //     Image = List;
                    //     RunObject = page "Student Subject Exam List";
                    //     RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CCSSE);
                    // }
                    // action("CBSE Score_3")
                    // {
                    //     Caption = 'CBSE Score';
                    //     ApplicationArea = All;
                    //     Image = List;
                    //     RunObject = page "Student Subject Exam List";
                    //     RunPageLink = "Student No." = FIELD("No."), "Score Type" = filter(CBSE);
                    // }
                    // Action("USMLE Scores_3")
                    // {
                    //     Caption = 'USMLE Scores';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = page "Student Subject Exam List";
                    //     RunPageLink = "Original Student No." = Field("Original Student No."), "Score Type" = filter("STEP 1" | "STEP 2 CS" | "STEP 2 CK");
                    // }
                    // action("Degree Audit List")
                    // {
                    //     Caption = 'Pending Degree Audit List';
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Degree Audit list";
                    //     RunPageLink = "Student No." = field("No.");
                    // }

                    // action("Approved/Rejected Degree Audit List")
                    // {
                    //     Caption = 'Approved / Rejected Degree Audit List';
                    //     Image = EntriesList;
                    //     ApplicationArea = All;
                    //     RunObject = Page "Approved Rejected Degree Audit";
                    //     RunPageLink = "Student No." = field("No.");
                    // }

                    // Action("Student Rotation Audit List")
                    // {
                    //     Caption = 'Student Rotation Audit';
                    //     Image = PostApplication;
                    //     ApplicationArea = All;
                    //     RunObject = page "Students Rotation Audit";
                    //     RunPageLink = "Original Student No." = Field("Original Student No.");
                    // }
                    action("&Student Subjet")
                    {
                        Caption = '&Student Subject';
                        image = GanttChart;
                        ApplicationArea = All;

                        RunObject = Page "Subject Student-CS";
                        RunPageLink = "ORiginal student No." = field("Original Student No.");



                    }

                    action("Student Subject Exams List")
                    {
                        Caption = 'Student Subject Exams';
                        Image = List;
                        ApplicationArea = All;
                        // RunObject = Page "Student Subject Exam List";
                        // RunPageLink = "Student No." = FIELD("No.");

                    }

                    group("Graduation Degree")
                    {

                        //     action("Student Degree")
                        //     {
                        //         Caption = 'Student Degree';
                        //         Image = Calculate;
                        //         ApplicationArea = All;
                        //         trigger OnAction()
                        //         Var
                        //             StudentDegreeRec: Record "Student Degree";
                        //             StudentDegree: Page "Student Degree";
                        //         begin
                        //             StudentDegreeRec.RESET();
                        //             StudentDegreeRec.SETRANGE("Student No.", Rec."No.");
                        //             StudentDegreeRec.SETRANGE("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                        //             IF StudentDegreeRec.Findfirst() then begin
                        //                 StudentDegree.Editable := False;
                        //                 StudentDegree.SETTABLEVIEW(StudentDegreeRec);
                        //                 StudentDegree.RUNMODAL();
                        //             end;
                        //         end;
                        //     }

                        // }
                        // Action("&Student Degree")
                        // {
                        //     Caption = 'Student Degree';
                        //     Image = List;
                        //     RunObject = page "Student Degree";
                        //     RunPageLink = "Student No." = field("No.");
                        // }

                        // Action("Student's Rotation Audit")
                        // {
                        //     Caption = 'Student Rotation Audit';
                        //     Image = PostApplication;
                        //     ApplicationArea = All;
                        //     RunObject = page "Students Rotation Audit";
                        //     RunPageLink = "Original Student No." = Field("Original Student No.");
                        // }
                        // action("Student Honors")
                        // {
                        //     Caption = 'Student Honors';
                        //     image = Account;
                        //     ApplicationArea = All;
                        //     RunObject = page "Student Honors";
                        //     RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                        // }
                        group("Student TranscriptsC1Print1")
                        {
                            Caption = 'Student Transcripts Print 1';
                            action("Official TranscriptCsPrint1")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsCRPrint1")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts(Rec);
                                end;
                            }
                        }

                        group("Student TranscriptsC1Print2")
                        {
                            Caption = 'Student Transcripts Print 2';
                            action("Official TranscriptCsPrint2")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts1(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsCRPrint2")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts1(Rec);
                                end;

                            }
                        }

                        group("Student TranscriptsC1Print3")
                        {
                            Caption = 'Student Transcripts Print 3';
                            action("Official TranscriptCsPrint3")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts2(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsCRPrint3")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts2(Rec);
                                end;
                            }
                        }
                        group("Student TranscriptsX2Print4")
                        {
                            Caption = 'Student Transcripts Print 4';
                            action("Official TranscriptXsPrint4")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts3(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsXRPrint4")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts3(Rec);
                                end;
                            }
                        }

                        group("Student TranscriptsV1Print5")
                        {
                            Caption = 'Student Transcripts Print 5';
                            action("Official TranscriptVsPrint5")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts4(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsVRPrint5")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts4(Rec);
                                end;

                            }
                        }

                        group("Student TranscriptsN1Print6")
                        {
                            Caption = 'Student Transcripts Print 6';
                            action("Official TranscriptNsPrint6")
                            {
                                Caption = 'Official Transcript';
                                Image = PrintReport;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                Begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.OfficialTranscripts5(Rec);
                                End;
                            }
                            action("Unofficial TranscriptsNRPrint6")
                            {
                                Caption = 'Unofficial Transcript';
                                Image = PrintReport;
                                ApplicationArea = All;
                                trigger OnAction()
                                var
                                    StudentStatusCU: Codeunit "Student Status Mangement";
                                begin
                                    StudentStatus.Get(Rec.Status, Rec."Global Dimension 1 Code");
                                    if StudentStatus.Status in [StudentStatus.Status::Deferred, StudentStatus.Status::Declined,
                                    StudentStatus.Status::Deposited] then
                                        Error('Transcript cannot be pulled for %1 status students.', Rec.Status);

                                    Clear(StudentStatusCU);
                                    StudentStatusCU.UnOfficialTranscripts5(Rec);
                                end;
                            }
                        }


                    }


                }

                group("In Person Registration")
                {
                    Image = ResourceRegisters;
                    Visible = GAffairsBoolean;
                    action("On Ground Check-In")
                    {
                        Caption = '&On Ground Check-In';
                        ApplicationArea = All;
                        Image = EntriesList;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Visible = GAffairsBoolean;
                        trigger OnAction()
                        var
                            RegistrarBool: Boolean;
                            HoldBool: Boolean;
                        begin
                            IF CONFIRM(Text006Lbl, FALSE, Rec."No.") THEN BEGIN
                                if Rec."Student Group" = Rec."Student Group"::" " then begin
                                    RegistrarBool := Rec.RegistrarHoldCheck(Rec."No.");
                                    if RegistrarBool then
                                        Error('Registrar Hold is Enable');


                                    HoldBool := Rec.HoldChecks(Rec);
                                    if HoldBool then
                                        Error('Hold are still present');
                                    Rec."Student Group" := Rec."Student Group"::"On-Ground Check-In";
                                    Rec."On Ground Check-In By" := UserId();
                                    Rec."On Ground Check-In On" := Today();
                                    Rec.Modify();
                                    Message(Text008Lbl, Rec."No.");
                                    CurrPage.Update();
                                end else
                                    Error('Student Group must be Blank.');
                            end else
                                exit;

                        end;
                    }
                    action("On Ground Check-Completed")
                    {
                        Caption = '&On Ground Check-Completed';
                        Image = EntriesList;
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedOnly = true;
                        PromotedCategory = Process;
                        Visible = GAffairsBoolean;
                        trigger OnAction()
                        var
                            RecHoldStatusLedger: Record "Hold Status Ledger";
                            StudentHoldRec: Record "Student Hold";
                            StudentStatusMangCod: Codeunit "Student Status Mangement";
                            HousingMail_lCU: Codeunit "Hosusing Mail";
                            StudentMappingReport: Report "Student Subject Mapping";
                            LastNo: Integer;

                        begin
                            IF CONFIRM(Text006Lbl, FALSE, Rec."No.") THEN BEGIN
                                if Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In" then begin
                                    // If "Returning Student" then
                                    //     If "Promotion Suggested" then begin
                                    //         HousingMail_lCU.StudentMasterUpdate('', Rec."No.");
                                    //OnGroundCheckInToComplete(Rec);
                                    Rec.OnGroundCheckInCmpltProcess(Rec);
                                    // end;
                                    Message(Text008Lbl, Rec."No.");
                                    CurrPage.Update();
                                end else
                                    Error('Student Group must be On-Ground Check-In.');
                            end else
                                exit;
                        end;

                    }
                    action(USMLE)
                    {
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        Image = MoveDown;
                        RunPageMode = View;
                        Caption = 'USMLE';
                        //Visible = NOT EEDClinical;
                        //                     trigger OnAction()
                        //                     var
                        //                         USMLERec: Record USMLE;
                        //                         USMLEList: Page "USMLE List";
                        //                         LastEntryNo: Integer;
                        //                     begin
                        //                         Rec.TestField(UsmleID);
                        //                         USMLERec.Reset();
                        //                         USMLERec.SetCurrentKey("Entry No.");
                        //                         USMLERec.SetRange("Student ID", Rec."No.");
                        //                         Rec.//"Original Student No."
                        // Clear(USMLEList);
                        //                         USMLEList.SetVariable(Rec."No.");
                        //                         Rec.//"Original Student No."
                        // USMLEList.SetTableView(USMLERec);
                        //                         USMLEList.RunModal();
                        //                     end;
                    }
                    //11.8.2021--> Start
                    action(SAFISync)
                    {
                        ApplicationArea = All;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        Image = MoveDown;
                        //RunPageMode = View;
                        Caption = 'SAFI Sync';
                        //Visible = NOT EEDClinical;
                        trigger OnAction()
                        begin
                            If Rec."Student SFP Initiation" <> 0 then begin
                                Rec."SAFI Sync" := Rec."SAFI Sync"::Pending;
                                Rec.Modify(True);
                            end;
                        end;
                    }
                    //11.8.2021--> END
                    action("Registrar Sign-Off")
                    {
                        Image = SignUp;
                        ApplicationArea = All;
                        Visible = False;
                        //Promoted = true;
                        //PromotedCategory = Category5;
                        trigger OnAction()

                        var
                            RecHoldStatusLedger: Record "Hold Status Ledger";
                            StudentHoldRec: Record "Student Hold";
                            StudentStatusMangCod: Codeunit "Student Status Mangement";
                            StudentMappingReport: Report "Student Subject Mapping";
                            LastNo: Integer;
                        begin
                            IF CONFIRM(Text010Lbl, FALSE, Rec."No.") THEN BEGIN
                                if Rec."Student Group" = Rec."Student Group"::"On-Ground Check-In Completed" then begin
                                    Rec.HoldChecks(Rec);

                                    RecHoldStatusLedger.Reset();
                                    if RecHoldStatusLedger.FINDLAST() then
                                        LastNo := RecHoldStatusLedger."Entry No." + 1
                                    else
                                        LastNo := 1;

                                    RecHoldStatusLedger.Init();
                                    RecHoldStatusLedger."Entry No." := LastNo;
                                    RecHoldStatusLedger."Student No." := Rec."No.";
                                    RecHoldStatusLedger."Student Name" := Rec."Student Name";
                                    RecHoldStatusLedger."Academic Year" := Rec."Academic Year";
                                    RecHoldStatusLedger."Admitted Year" := Rec."Admitted Year";
                                    RecHoldStatusLedger.Semester := Rec.Semester;
                                    RecHoldStatusLedger."Entry Date" := Today();
                                    RecHoldStatusLedger."Entry Time" := Time();
                                    RecHoldStatusLedger."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                                    RecHoldStatusLedger."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
                                    RecHoldStatusLedger."User ID" := FORMAT(UserId());
                                    RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::"Registrar Sign-off";

                                    StudentHoldRec.Reset();
                                    StudentHoldRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Registrar Sign-off");
                                    StudentHoldRec.FindFirst();

                                    RecHoldStatusLedger."Hold Code" := StudentHoldRec."Hold Code";
                                    RecHoldStatusLedger."Hold Description" := StudentHoldRec."Hold Description";
                                    RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Enable;
                                    RecHoldStatusLedger.Insert();
                                    //Report.Run(Report::"Student Subject Update CS", false, false, Rec);

                                    Clear(StudentMappingReport);
                                    StudentMappingReport.SetTableView(Rec);
                                    StudentMappingReport.Setdata(Rec);
                                    StudentMappingReport.UseRequestPage(false);
                                    StudentMappingReport.Run();

                                    Rec.Validate("Registrar Signoff", true);
                                    REc."Returning Student" := true;
                                    Rec.validate(Status, StudentStatusMangCod.RegistrarSignoff(Rec."No.", Rec.Status, Rec.Semester, Rec."Global Dimension 1 Code"));
                                    Rec.Modify();
                                    Message(Text012Lbl, Rec."No.");
                                    CurrPage.Update();
                                end else
                                    Error('Student Group must be On-Ground Check-In Completed');
                            end else
                                exit;

                        end;
                    }
                }
                group(Registrar)
                {


                    action("Registrar Hold Enable")
                    {
                        Image = Open;
                        ApplicationArea = All;
                        PromotedCategory = Category5;
                        Promoted = true;
                        Visible = RegistrarHoldVisible;
                        trigger OnAction()
                        Var
                            StudentStatusMangCod: Codeunit "Student Status Mangement";
                        begin
                            IF CONFIRM(Text013Lbl, FALSE, Rec."No.") THEN BEGIN
                                StudentStatusMangCod.EnableRegistrarHold(Rec);
                                Message(Text014Lbl, Rec."No.");
                                CurrPage.Update();
                            end else
                                exit;
                        end;
                    }
                    action("Registrar Hold Disable")
                    {
                        Image = Close;
                        Visible = RegistrarHoldVisible;
                        ApplicationArea = All;
                        PromotedCategory = Category5;
                        Promoted = true;
                        trigger OnAction()
                        var
                            StudentStatusMangCod: Codeunit "Student Status Mangement";
                        begin
                            IF CONFIRM(Text015Lbl, FALSE, Rec."No.") THEN BEGIN
                                StudentStatusMangCod.DisableRegistrarHold(Rec);
                                Message(Text016Lbl, Rec."No.");
                                CurrPage.Update();
                            end else
                                exit;
                        end;
                    }
                }
                action("View/Update Notes")
                {
                    ApplicationArea = All;
                    Caption = 'View/Update Notes';
                    Image = Notes;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                        TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                        GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                    begin
                        Rec.TestField("No.");
                        TemplateType := TemplateType::Student;
                        GroupType := GroupType::Student;
                        ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."No.", Rec."No.", TemplateType, GroupType);
                    end;
                }
                action("Add Attachment")
                {
                    ApplicationArea = All;
                    Caption = 'Add Attachment';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        StudentMaster: Record "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.SetRange("No.", Rec."No.");
                        // Page.RunModal(Page::"Add Student Attachment", StudentMaster);
                    end;
                }

                action("Add Attachments")
                {
                    ApplicationArea = All;
                    Caption = 'View All Attachment';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        StudentMaster: Record "Student Master-CS";
                    begin
                        StudentMaster.Reset();
                        StudentMaster.SetRange("No.", Rec."No.");
                        // Page.RunModal(Page::"Add Student Attachments", StudentMaster);
                    end;
                }
                action("Update GPA")
                {
                    ApplicationArea = All;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        StudentStatusMgmt: Codeunit "Student Status Mangement";
                    Begin
                        Clear(StudentStatusMgmt);
                        If Confirm('Do you want to Calculate GPA?', true) then
                            StudentStatusMgmt.UpdateGPA(Rec."No.", false)
                        Else
                            Exit;
                    End;
                }

                Action("Consolidated Student Ledger")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    trigger OnAction()
                    var
                        Customer_lRec: Record Customer;
                        ConsolidatedStudentLedger: Report "Consolidated Student Ledger";
                    Begin
                        Clear(ConsolidatedStudentLedger);
                        Customer_lRec.Reset();
                        Customer_lRec.SetRange("No.", Rec."Original Student No.");
                        Customer_lRec.SetRange("Date Filter", 0D, CALCDATE('<1Y>', Today));//GAURAV//22/07/22//
                                                                                           // Customer_lRec.SetRange("Global Dimension 2 Filter", '');
                                                                                           // Report.RunModal(Report::"Consolidated Student Ledger", True, False, Customer_lRec);
                        ConsolidatedStudentLedger.SetTableView(Customer_lRec);
                        ConsolidatedStudentLedger.GetDepartmentFilter('''''');
                        ConsolidatedStudentLedger.Run();
                    End;
                }

                Action("Developer User only")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    trigger OnAction()
                    var
                        DeleteData : Codeunit "Data Delete Tool";
                    Begin
                        Clear(DeleteData);
                        DeleteData.Run();
                    End;
                }
                Action("Repeat Semester")
                {
                    ApplicationArea = All;
                    Image = ChangeTo;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    Trigger OnAction()
                    Begin
                        IF Not Confirm('Do you want to repeat a semester.?', False) then
                            Exit;

                        Rec.TestField("Semester Decision", Rec."Semester Decision"::" ");
                        Rec.Testfield("Returning Student");
                        Rec.StudentSemesterDecisionInsert(Rec, Rec."Semester Decision"::"Repeat ");
                        Message('Semester Updated Successfully');
                        Currpage.Update();

                    End;

                }
                action("Course Change")
                {
                    ApplicationArea = All;
                    Image = Report;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    // RunObject = Page "Student Course Change";
                    // RunPageLink = "No." = field("No.");
                }
                Action("Restart Semester")
                {
                    ApplicationArea = All;
                    Caption = 'Restart Year';
                    Image = ChangeTo;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    Trigger OnAction()
                    Begin
                        IF Not Confirm('Do you want to restart a Year.?', False) then
                            Exit;

                        Rec.TestField("Semester Decision", Rec."Semester Decision"::" ");
                        Rec.Testfield("Returning Student");
                        // StudentSemesterDecisionInsert(Rec, Rec."Semester Decision"::Restart);
                        Message('Semester Updated Successfully');
                        Currpage.Update();

                    End;

                }
                Action("Repeat Semester List")
                {
                    ApplicationArea = All;
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    // RunObject = Page "Student Semester Log Entry";
                    // RunPageView = where("Semester Decision" = filter("Repeat "));
                }
                Action("Restart Semester List")
                {
                    ApplicationArea = All;
                    Caption = 'Restart Year List';
                    Image = List;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    //Visible = NOT EEDClinical;
                    // RunObject = Page "Student Semester Log Entry";
                    // RunPageView = where("Semester Decision" = filter(Restart));
                }
                Action("Airport Check-in Enabled")//GAURAV//25//01//23//START
                {
                    ApplicationArea = All;
                    Image = Closed;
                    Promoted = true;
                    PromotedOnly = true;
                    //Enabled = Not (Rec."Airport Check-in");
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        myInt: Integer;

                    begin
                        Rec."Airport Check-in" := true;
                        Rec."Airport Check-in date" := today;
                        Rec.Modify();
                        MESSAGE(Text0029Lbl);

                    end;

                }

                Action("Airport Check-in Disabled")//GAURAV//25//01//23//START
                {
                    ApplicationArea = All;
                    Image = SignUp;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        myInt: Integer;

                    begin
                        Rec."Airport Check-in" := FALSE;
                        Rec."Airport Check-in date" := 0D;
                        Rec.Modify();
                        MESSAGE(Text0030Lbl);


                    end;
                }
                action("Send OLR Email")
                {
                    ApplicationArea = All;
                    Caption = 'Send OLR Email';
                    Image = Email;
                    Visible = OLREmailButton;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;
                    trigger OnAction()
                    var
                        HousingMailCod: Codeunit "Hosusing Mail";
                        Text017Lbl: Label 'Do you want to Send Email to Student No. %1 ?';
                        Text018Lbl: Label 'Email has been sent to Student No. %1 .';
                    begin
                        If CONFIRM(Text017Lbl, false, Rec."No.") then begin
                            if Rec."Returning Student" then
                                Error('The Student No. %1 is Returning Student', Rec."No.");

                            //if "OLR Email Sent" = false then begin
                            HousingMailCod.ReturningStudentOnlineRegistrationEmail(Rec."No.");
                            // "OLR Email Sent" := true;
                            // "OLR Email Sent Date" := Today();
                            //Modify();
                            Message(Text018Lbl, Rec."No.");
                            // end else
                            //     Error('OLR Email is already send to Student No. %1', Rec."No.");
                        end else
                            exit;
                    end;
                }
                action("Immigration Hold Enable")
                {
                    Caption = 'Student Services Hold Enable';
                    Image = Closed;
                    Visible = ImmigrationHoldVisible;
                    ApplicationArea = All;
                    PromotedCategory = Category7;
                    Promoted = true;
                    trigger OnAction()
                    Var
                        StudentTimeLineRec: Record "Student Time Line";
                        StudentStatusMangCod: Codeunit "Student Status Mangement";
                        Text0017Lbl: Label 'Do you want to enable the Student Services Hold for Student No. %1';
                        Text0018Lbl: Label 'Student Services Hold enabled for Student No. %1';
                    begin
                        IF CONFIRM(Text0017Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Immigration);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Student Services Hold Enable', UserID(), Today());
                            Message(Text0018Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }
                action("Immigration Hold Disable")
                {
                    Caption = 'Student Services Hold Disable';
                    Visible = ImmigrationHoldVisible;
                    Image = SignUp;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category7;
                    trigger OnAction()
                    var
                        StudentTimeLineRec: Record "Student Time Line";
                        Text001Lbl: Label 'Do you want to Sign-Off Student Services Hold for Student No. %1?';
                        Text002Lbl: Label 'Student Services Hold Sign-Off has been completed for Student No. %1';
                    begin
                        IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                            Rec.ImmigrationHoldSignoff(Rec);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Student Services Hold Disable', UserID(), Today());
                            Message(Text002Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }
                action("Bursar Hold")
                {
                    Image = Closed;
                    Visible = BursarHoldVisible;
                    //Visible = False;
                    ApplicationArea = All;
                    PromotedCategory = Category8;
                    Promoted = true;
                    trigger OnAction()
                    Var
                        StudentTimeLineRec: Record "Student Time Line";
                        StudentStatusMangCod: Codeunit "Student Status Mangement";
                        Text0017Lbl: Label 'Do you want to enable the Bursar Hold for Student No. %1';
                        Text0018Lbl: Label 'Bursar Hold enabled for Student No. %1';
                    begin
                        IF CONFIRM(Text0017Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::Bursar);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Bursar Hold Enable', UserId(), Today());
                            Message(Text0018Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }
                action("Bursar Signof")
                {
                    Caption = '&Bursar Signoff';
                    Visible = BursarHoldVisible;
                    //Visible = False;
                    Image = SignUp;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category8;
                    trigger OnAction()
                    var
                        StudentTimeLineRec: Record "Student Time Line";
                        Text001Lbl: Label 'Do you want to Sign-Off Bursar Hold for Student No. %1?';
                        Text002Lbl: Label 'Bursar Hold Sign-Off has been completed for Student No. %1';

                    begin
                        IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                            if Rec.BursarHoldCheck(Rec."No.") = true then begin
                                Rec.BursarSignoff(Rec."No.");
                                StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Bursar Hold Disable', UserId(), Today());
                                Message(Text002Lbl, Rec."No.");
                                CurrPage.Update();
                            end;
                        end else
                            exit;
                    end;
                }

                action("OLR Finance Holds E")//GMCS//02052023
                {
                    Caption = 'OLR Finance Hold Enable';
                    Image = Closed;
                    ApplicationArea = All;
                    PromotedCategory = Category14;
                    Promoted = true;
                    Visible = OLRFinanceVisible;
                    Trigger OnAction()
                    var
                        StudentMaster: rEcord "Student Master-CS";
                        StudentTimeLineRec: Record "Student Time Line";
                        StudentStatusMgmt: Codeunit "Student Status Mangement";
                        HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
                        Text0017Lbl: Label 'Do you want to enable the OLR Finance Hold for Student No. %1?';
                        Text0018Lbl: Label 'OLR Finance Hold enabled for Student No. %1';

                    begin
                        IF CONFIRM(Text0017Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentMaster.Reset();
                            StudentMaster.SetRange("Original Student No.", Rec."Original Student No.");
                            IF StudentMaster.Findset then begin
                                Repeat
                                    StudentStatusMgmt.EnableAllHoldOLR(StudentMaster, HoldType::"OLR Finance");
                                    StudentTimeLineRec.InsertRecordFun(StudentMaster."No.", Rec."Student Name", 'OLR Finance Hold Enable', UserId(), Today());
                                until StudentMaster.Next() = 0;
                            end;
                            Message(Text0018Lbl, Rec."Original Student No.");
                            CurrPage.Update();

                        end else
                            exit;
                    end;
                }
                action("OLR Finance Holds D")//GMCS//02052023
                {
                    Caption = 'OLR Finance Hold Disable';
                    Image = Closed;
                    ApplicationArea = All;
                    PromotedCategory = Category14;
                    Promoted = true;
                    Visible = OLRFinanceVisible;
                    Trigger OnAction()
                    var
                        StudentMaster: Record "Student Master-CS";
                        StudentTimeLineRec: Record "Student Time Line";
                        StudentStatusMgmt: Codeunit "Student Status Mangement";
                        HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
                        Text0017Lbl: Label 'Do you want to disable the OLR Finance Hold for Student No. %1?';
                        Text0018Lbl: Label 'OLR Finance Hold disabled for Student No. %1';

                    begin
                        IF CONFIRM(Text0017Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentMaster.Reset();
                            StudentMaster.SetRange("Original Student No.", Rec."Original Student No.");
                            IF StudentMaster.Findset then begin
                                Repeat
                                    if Rec.HoldChecksOLRFinance(StudentMaster) = true then begin
                                        StudentStatusMgmt.DisableAllHoldOLR(StudentMaster, HoldType::"OLR Finance");
                                        StudentTimeLineRec.InsertRecordFun(StudentMaster."No.", Rec."Student Name", 'OLR Finance Hold disable', UserId(), Today());
                                    end;
                                until StudentMaster.Next() = 0;
                            end;
                            Message(Text0018Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }
                action("Financial AID Hold Enable")
                {
                    Image = Closed;
                    Visible = FinCourseHoldVisible;
                    ApplicationArea = All;
                    PromotedCategory = Category9;
                    Promoted = true;
                    trigger OnAction()
                    Var
                        StudentTimeLineRec: Record "Student Time Line";
                        StudentStatusMangCod: Codeunit "Student Status Mangement";
                    begin
                        IF CONFIRM(Text017Lbl, FALSE, Rec."No.") THEN BEGIN
                            StudentStatusMangCod.EnableAllHold(Rec, HoldType::"Financial Aid");
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Financial Aid Hold Enable', UserId(), Today());
                            Message(Text018Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }
                action("Financial Aid Hold Disable")
                {
                    Caption = '&Financial Aid Hold Disable';
                    Visible = FinCourseHoldVisible;
                    Image = SignUp;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category9;
                    trigger OnAction()
                    var
                        StudentTimeLineRec: Record "Student Time Line";
                        Text001Lbl: Label 'Do you want to Sign-Off Financial Aid for Student No. %1?';
                        Text002Lbl: Label 'Financial Aid Hold Sign-Off has been completed for Student No. %1';
                    begin
                        // if "Type of FA Roster" = "Type of FA Roster"::" " then
                        //     Error('Kindly update Type Of FA Roster.');

                        IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                            REc.FinancialAidSignoff(Rec);
                            StudentTimeLineRec.InsertRecordFun(Rec."No.", Rec."Student Name", 'Financial Aid Hold Disable', UserId(), Today());
                            Message(Text002Lbl, Rec."No.");
                            CurrPage.Update();
                        end else
                            exit;
                    end;
                }

                action("Generate E-Mail Address")
                {
                    Caption = 'Generate E-Mail Address';
                    Image = OutlookSyncFields;
                    //Visible = NOT EEDClinical;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PortalUserLoginCS: Record "Portal User Login-CS";
                        GenWebJournal: Codeunit "Gen. Web  Journal -CS";
                        // WebServFunc: Codeunit WebServicesFunctionsCSL;
                        SFStudentCreate: Codeunit SFStudentCreationAuto;
                    begin

                        //Student_EmailCreation
                        // WebServFunc.StudentEmailCreation(Rec, 1);
                        PortalUserLoginCS.Reset();
                        PortalUserLoginCS.SetRange(U_ID, Rec."No.");
                        PortalUserLoginCS.FindFirst();
                        Rec.TestField("E-Mail Address");
                        PortalUserLoginCS.TestField("Login ID");
                        Rec.TestField(Password);
                        GenWebJournal.StudentMissingFieldToSF(Rec."No.", PortalUserLoginCS."Login ID", Rec."E-Mail Address", Rec.Password);
                        IF NOT Confirm('Do you want to send Credentials Email to Student ?', False) then
                            exit;
                        // SFStudentCreate.EmailTrigger(Rec);
                    end;
                }
                action("Student Group")
                {
                    Caption = 'Student Group';
                    Image = EntriesList;
                    ApplicationArea = All;

                    // RunObject = Page "Student Group";
                    // RunPageLink = "Student No." = FIELD("No."), "Enrollment No." = field("Enrollment No.");

                }
                // action("Student Document")
                // {
                //     Caption = 'Student Document';
                //     image = Account;
                //     ApplicationArea = All;
                //     RunObject = page "Student Document Attachment";
                //     RunPageLink = "Student No." = FIELD("No."), "Enrolment No." = field("Enrollment No.");

                // }
                // area(navigation)
                // { 
                //     group("&Student")
                //     {
                //         Caption = '&Student';
                //         action("Student Examination Details")
                //         {
                //             Caption = 'Student Examination Details';
                //             Image = Setup;
                //             ApplicationArea = All;
                //             RunObject = Page "50282";
                //             Visible = false;
                //         }

                //         action("Student Branch Transfer")
                //         {
                //             Caption = 'Student Branch Transfer';
                //             Image = TransferFunds;
                //             ApplicationArea = All;
                //             RunObject = Page 50110;
                //             Visible = false;
                //             RunPageLink = "No." = FIELD("No.");
                //         }
                //         action("Student Transfer")
                //         {
                //             Image = TransferFunds;
                //             ApplicationArea = All;
                //             Visible = false;
                //         }
                //         action("Student Un Transfer")
                //         {
                //             Image = Change;
                //             Visible = false;
                //             ApplicationArea = All;
                //             trigger OnAction()
                //             begin
                //                 //Code added for Report Run::CSPL-00092::29-05-2019: Start
                //                 CurrPage.SETSELECTIONFILTER(StudentMasterCS);
                //                 REPORT.RUN(50050, TRUE, FALSE, StudentMasterCS);
                //                 //Code added for Report Run::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Page Application Certificates")
                //         {
                //             Caption = 'Certificate';
                //             RunObject = Page 50282;
                //             RunPageLink = "Student No." = FIELD("No.");
                //             Visible = false;
                //             ApplicationArea = All;
                //         }
                //         action("Student Modified Record List")
                //         {
                //             RunObject = Page 595;
                //             RunPageLink = "Primary Key Field 1 Value" = FIELD("No.");
                //             ApplicationArea = All;
                //             Visible = false;

                //         }
                //         action("Student Attachment")
                //         {
                //             RunObject = Page 50026;
                //             ApplicationArea = All;
                //             Visible = false;
                //             RunPageLink = "Student No." = FIELD("No.");
                //         }
                //         action("Send on Boarding Email")
                //         {
                //             Caption = 'Send on boading Email';
                //             Image = MailAttachment;
                //             ApplicationArea = All;
                //             Visible = false;
                //             trigger OnAction()
                //             begin
                //                 //Code added for Generate Portl User::CSPL-00092::29-05-2019: Start
                //                 PortalUser();
                //                 //Code added for Generate Portl User::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Student Data Upload")
                //         {
                //             Promoted = true;
                //             PromotedOnly = true;
                //             ApplicationArea = All;
                //             trigger OnAction()
                //             begin
                //                 //Code added for Run XmlPort::CSPL-00092::29-05-2019: Start
                //                 XMLPORT.RUN(50001, TRUE, TRUE, Rec);
                //                 //Code added for Run XmlPort::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Update Student Details")
                //         {
                //             Promoted = true;
                //             PromotedOnly = true;
                //             ApplicationArea = All;
                //             Visible = false;
                //             trigger OnAction()
                //             begin
                //                 //Code added for Run XmlPort::CSPL-00092::29-05-2019: Start
                //                 XMLPORT.RUN(50002, TRUE, TRUE, Rec);
                //                 //Code added for Run XmlPort::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Update Student Subject (Core)")
                //         {
                //             Promoted = true;
                //             PromotedOnly = true;
                //             ApplicationArea = All;
                //             Visible = false;
                //             trigger OnAction()
                //             var
                //                 InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                //             begin
                //                 //Code added for Update Student Subject::CSPL-00092::29-05-2019: Start
                //                 InformationOfStudentCS.StudentSubjectUpdateCS("No.");
                //                 //Code added for Update Student Subject::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Academic Details")
                //         {
                //             Promoted = true;
                //             PromotedOnly = true;
                //             ApplicationArea = All;
                //             Visible = false;

                //             trigger OnAction()
                //             var
                //                 InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
                //             begin
                //                 //Code added for Update Student Subject::CSPL-00092::29-05-2019: Start
                //                 InformationOfStudentCS.StudentSubjectUpdateCS("No.");
                //                 //Code added for Update Student Subject::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Hostel Information")
                //         {
                //             Image = PostedTimeSheet;
                //             RunObject = Page 50077;
                //             Visible = false;
                //             ApplicationArea = All;
                //             RunPageLink = "Student No." = FIELD("No.");
                //         }
                //         action("Student Details Mentors Import")
                //         {
                //             Image = ListPage;
                //             Promoted = true;
                //             PromotedOnly = true;
                //             Visible = false;
                //             RunObject = Page 50112;
                //             RunPageLink = "No." = FIELD("No.");
                //             ApplicationArea = All;
                //         }

                //         action("Update Student Subject & Optional Subject")
                //         {
                //             Caption = 'Update Subject & Optional Subject';
                //             Image = "Report";
                //             Visible = false;
                //             RunObject = Report 50039;
                //             ApplicationArea = All;
                //         }
                //         action("Total Credit Earned")
                //         {
                //             Image = Calculate;
                //             ApplicationArea = All;
                //             Promoted = true;
                //             PromotedOnly = true;
                //             PromotedIsBig = true;
                //             Visible = false;
                //             trigger OnAction()
                //             begin
                //                 //Code added for Find total Credit::CSPL-00092::29-05-2019: Start
                //                 TotalCreditEarned := "Semester I Credit Earned" + "Semester II Credit Earned" + "Semester III Credit Earned" + "Semester IV Credit Earned" +
                //                                      "Semester V Credit Earned" + "Semester VI Credit Earned" + "Semester VII Credit Earned" + "Semester VIII Credit Earned";
                //                 MESSAGE('%1', TotalCreditEarned);
                //                 //Code added for Find total Credit::CSPL-00092::29-05-2019: End
                //             end;
                //         }
                //         action("Calculate Results")
                //         {
                //             Image = Calculate;
                //             ApplicationArea = All;
                //             Promoted = true;
                //             PromotedOnly = true;
                //             PromotedIsBig = true;
                //             Visible = false;

                //             trigger OnAction()
                //             begin
                //                 //Code added for Run Page::CSPL-00092::29-05-2019: Start
                //                 CLEAR(ResultsStudentCS);
                //                 ResultsStudentCS.GetData(Rec."No.");
                //                 IF ResultsStudentCS.RUNMODAL() = ACTION::LookupOK THEN;
                //                 //Code added for Run Page::CSPL-00092::29-05-2019: Start
                //             end;
                //         }

                //     }
                //  }

            }
        }
    }
    trigger OnInit()
    begin
        Social := false;
        SocialSec := false;
    end;

    trigger OnAfterGetRecord()
    begin
        //Code added for Flag Condition Base True of false::CSPL-00092::29-05-2019: Start
        HousingGroupText := '';
        HousingID := '';
        ApartmentCategoryCode := '';
        ApartmentNo := '';
        RoomNo := '';
        HousingGroupText := Rec.HostelRoomBedAssigned(REc."No.", 3);
        HousingID := Rec.HostelRoomBedAssigned(REc."No.", 0);
        ApartmentCategoryCode := Rec.HostelRoomBedAssigned(REc."No.", 4);
        ApartmentNo := Rec.HostelRoomBedAssigned(REc."No.", 1);
        RoomNo := Rec.HostelRoomBedAssigned(REc."No.", 2);


        IF Rec."Type Of Course" = Rec."Type Of Course"::Year THEN BEGIN
            EditableBTNSEM := FALSE;
            EditableBTNYR := TRUE;
        END ELSE BEGIN
            EditableBTNYR := FALSE;
            EditableBTNSEM := TRUE;
        END;

        Boolean_gBool := false;
        If Rec."Payment Plan Applied" then
            Boolean_gBool := true;

        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;
        //Code added for Flag Condition Base True of false::CSPL-00092::29-05-2019: End

        FinancialAid_GBoo := false;
        CourseHoldVisible := false;
        if CourseMaster.Get(Rec."Course Code") then begin
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;
        end
        else begin
            if UserSetup.Get(UserId()) then
                if UserSetup."Global Dimension 1 Code" <> '9100' then
                    FinancialAid_GBoo := true;
        end;

        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;

        OLREmailButton := true;
        if Rec."Returning Student" then
            OLREmailButton := false;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                RegistrarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                BursarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then Begin
            FinancialAIDHoldVisible := true;
            FinancialAidDepartment := true;
        end
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then begin
                FinancialAIDHoldVisible := true;
                FinancialAidDepartment := true;
            end;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Residential Services") then
            ImmigrationHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                ImmigrationHoldVisible := true;
        // end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"EED Clinical") then
            EEDClinical := true
        else
            EEDClinical := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"EED Pre-Clinical") then begin
            IF UserSetup.Get(UserId) then;
            IF UserSetup."EED Chair" then
                EEDChairCanView := true
            else
                EEDChairCanView := false;
        end else
            EEDChairCanView := true;//This boolean is only for EED Pre clinical not for ther departments
        Rec.UpdateExamBestValues();
        BlankDates();//CSPL-00307-17-05-2022

        OLRFinanceVisible := False;
        If usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            OLRFinanceVisible := True;
        IF usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            OLRFinanceVisible := True;

        IF (Rec."Fathers Name" = 'NA') OR (Rec."Fathers Name" = 'Not Applicable') Then////
            FatherEnable := False
        Else
            FatherEnable := True;

        IF (Rec."Father Contact Number" = 'NA') OR (Rec."Father Contact Number" = 'Not Applicable') Then
            FatherContactNumber := False
        Else
            FatherContactNumber := True;

        IF (Rec."Father Email ID" = 'NA') OR (Rec."Father Email ID" = 'Not Applicable') Then
            FatherEmailID := False
        Else
            FatherEmailID := True;
        IF (Rec."Mothers Name" = 'NA') OR (Rec."Mothers Name" = 'Not Applicable') Then
            MothersName := False
        Else
            MothersName := True;

        IF (Rec."Mother Contact Number" = 'NA') OR (Rec."Mother Contact Number" = 'Not Applicable') Then
            MotherContactNumber := False
        Else
            MotherContactNumber := True;

        IF (Rec."Mother Email ID" = 'NA') OR (Rec."Mother Email ID" = 'Not Applicable') Then
            MotherEmailID := False
        Else
            MotherEmailID := True;

        IF (Rec."Guardian Name" = 'NA') OR (Rec."Guardian Name" = 'Not Applicable') Then
            GuardianName := False
        Else
            GuardianName := True;

        IF (Rec."Guardian Contact Number" = 'NA') OR (Rec."Guardian Contact Number" = 'Not Applicable') Then
            GuardianContactNumber := False
        Else
            GuardianContactNumber := True;

        IF (Rec."Guardian Email ID" = 'NA') OR (Rec."Guardian Email ID" = 'Not Applicable') Then
            GuardianEmailID := False
        Else
            GuardianEmailID := True;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for Flag false::CSPL-00092::29-05-2019: Start
        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;

        Boolean_gBool := false;
        If Rec."Payment Plan Applied" then
            Boolean_gBool := true;
        //Code added for Flag false::CSPL-00092::29-05-2019: End
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;
    end;

    trigger OnOpenPage()

    begin
        //Code added for Flag Condition Base True of false::CSPL-00092::29-05-2019: Start
        // FinBool := true;
        //     if UserSetup.Get(UserId()) then
        //         if UserSetup."Global Dimension 1 Code" = '9100' then
        //             FinBool := false;
        RoleAndPermission();
        RoleAndPermissionNew();

        OLREmailButton := true;
        if Rec."Returning Student" then
            OLREmailButton := false;

        IF UserSetup.Get(UserId()) then;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            Social := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
                Social := true
            else
                if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::Admissions) then
                    Social := true
                else
                    If UserSetup."SSN Permissions" then
                        Social := true
                    Else
                        Social := false;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            SocialSec := false
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
                SocialSec := false
            else
                if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::Admissions) then
                    SocialSec := false
                else
                    IF UserSetup."SSN Permissions" then
                        SocialSec := False
                    Else
                        SocialSec := true;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::Admissions) then
        //         Social := true
        //     else
        //         Social := false;

        // if UserSetup.Get(UserId()) then
        //     if (UserSetup."Department Approver" = UserSetup."Department Approver"::"Bursar Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::"Financial Aid Department") or
        //     (UserSetup."Department Approver" = UserSetup."Department Approver"::Admissions) then
        //         SocialSec := false
        //     else
        //         SocialSec := true;


        if Rec."Social Security No." <> '' then begin
            SocialSecurity := '*******' + COPYSTR(Rec."Social Security No.", 8, 4);
        end;

        EditableBTNSEM := TRUE;
        EditableBTNYR := TRUE;
        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Student Edit" THEN
                EditCard := TRUE
            ELSE
                EditCard := FALSE;

        Boolean_gBool := false;
        If Rec."Payment Plan Applied" then
            Boolean_gBool := true;

        RegistrarBool := Rec.RegistrarHoldCheck(Rec."No.");
        RegistrarHold := 'Registrar Hold';


        //Code added for Flag Condition Base True of false::CSPL-00092::29-05-2019: End

        //SD-SN-17-Dec-2020 +
        FinancialAid_GBoo := false;
        CourseHoldVisible := false;
        if CourseMaster.Get(Rec."Course Code") then begin
            if CourseMaster."Financial AID Applicable" then begin
                FinancialAid_GBoo := true;
                CourseHoldVisible := true;
            end;
        end
        else begin
            if UserSetup.Get(UserId()) then
                if UserSetup."Global Dimension 1 Code" <> '9100' then
                    FinancialAid_GBoo := true;
        end;
        //SD-SN-17-Dec-2020 -

        RegistrarHoldVisible := false;
        BursarHoldVisible := false;
        FinancialAIDHoldVisible := false;
        ImmigrationHoldVisible := false;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Registrar Department") then
            RegistrarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                RegistrarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            BursarHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                BursarHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            FinancialAIDHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                FinancialAIDHoldVisible := true;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"Residential Services") then
            ImmigrationHoldVisible := true
        else
            if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::" ") then
                ImmigrationHoldVisible := true;
        //    end;
        if (FinancialAIDHoldVisible) and (CourseHoldVisible) then
            FinCourseHoldVisible := true
        else
            FinCourseHoldVisible := false;

        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"EED Clinical") then
            EEDClinical := true
        else
            EEDClinical := false;
        if usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"EED Pre-Clinical") then begin
            IF UserSetup.Get(UserId) then;
            IF UserSetup."EED Chair" then
                EEDChairCanView := true
            else
                EEDChairCanView := false;
        end else
            EEDChairCanView := true;//This boolean is only for EED Pre clinical not for ther departments
        ShowFerpaDetail := false;
        HideFerpaDetail := false;
        If UserSetup."Ferpa Insert Allowed" then begin
            ShowFerpaDetail := true;
            HideFerpaDetail := false;
        end Else begin
            ShowFerpaDetail := false;
            HideFerpaDetail := true;
        end;

        IF (Rec."Fathers Name" = 'NA') OR (Rec."Fathers Name" = 'Not Applicable') Then////
            FatherEnable := False
        Else
            FatherEnable := True;

        IF (Rec."Father Contact Number" = 'NA') OR (Rec."Father Contact Number" = 'Not Applicable') Then
            FatherContactNumber := False
        Else
            FatherContactNumber := True;

        IF (Rec."Father Email ID" = 'NA') OR (Rec."Father Email ID" = 'Not Applicable') Then
            FatherEmailID := False
        Else
            FatherEmailID := True;
        IF (Rec."Mothers Name" = 'NA') OR (Rec."Mothers Name" = 'Not Applicable') Then
            MothersName := False
        Else
            MothersName := True;

        IF (Rec."Mother Contact Number" = 'NA') OR (Rec."Mother Contact Number" = 'Not Applicable') Then
            MotherContactNumber := False
        Else
            MotherContactNumber := True;

        IF (Rec."Mother Email ID" = 'NA') OR (Rec."Mother Email ID" = 'Not Applicable') Then
            MotherEmailID := False
        Else
            MotherEmailID := True;

        IF (Rec."Guardian Name" = 'NA') OR (Rec."Guardian Name" = 'Not Applicable') Then
            GuardianName := False
        Else
            GuardianName := True;

        IF (Rec."Guardian Contact Number" = 'NA') OR (Rec."Guardian Contact Number" = 'Not Applicable') Then
            GuardianContactNumber := False
        Else
            GuardianContactNumber := True;

        IF (Rec."Guardian Email ID" = 'NA') OR (Rec."Guardian Email ID" = 'Not Applicable') Then
            GuardianEmailID := False
        Else
            GuardianEmailID := True;

        OLRFinanceVisible := False;
        If usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Bursar Department") then
            OLRFinanceVisible := True;
        IF usersetupapprover.Get(USerID(), usersetupapprover."Department Approver Type"::"Financial Aid Department") then
            OLRFinanceVisible := True;

    end;

    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentStatus: Record "Student Status";
        UserSetup: Record "User Setup";
        StudentMasterCS: Record "Student Master-CS";
        //SD-SN-17-Dec-2020 +
        CourseMaster: Record "Course Master-CS";
        //SD-SN-17-Dec-2020 -
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        usersetupapprover: Record "Document Approver Users";
        RegistrarHold: code[20];
        HoldType: option " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
        //SD-SN-17-Dec-2020 +
        FinancialAid_GBoo: Boolean;

        //SD-SN-17-Dec-2020 -
        EditableBTNSEM: Boolean;
        EditableBTNYR: Boolean;
        EditCard: Boolean;
        Bool: Boolean;
        Boolean_gBool: Boolean;
        RegistrarBool: Boolean;
        OLRFinanceVisible: Boolean;
        GAffairsBoolean: Boolean;
        RegistrarHoldVisible: Boolean;
        BursarHoldVisible: Boolean;
        FinancialAIDHoldVisible: Boolean;
        ImmigrationHoldVisible: Boolean;
        FinCourseHoldVisible: Boolean;
        CourseHoldVisible: Boolean;

        OLREmailButton: Boolean;
        Text006Lbl: Label 'Do you want to change student group for Student No. %1?';
        Text008Lbl: Label 'Student No. %1 group has been changed.';
        Text010Lbl: Label 'Do you want to map the course for Student No. %1?';
        Text012Lbl: Label 'Student No. %1 course has been Mapped.';
        Text013Lbl: Label 'Do you want to enable the Registrar Hold for Student No. %1';
        Text014Lbl: Label 'Registrar Hold enabled for Student No. %1';
        Text015Lbl: Label 'Do you want to disable the Registrar Hold for Student No. %1';
        Text016Lbl: Label 'Registrar Hold disabled for Student No. %1';
        Text017Lbl: Label 'Do you want to enable the Financial AID Hold for Student No. %1';
        Text018Lbl: Label 'Financial AID Hold enabled for Student No. %1';

        Text0021Lbl: Label 'Do you want to process the Student Initiation for selected Students?';
        Text0022Lbl: Label 'Do you want to process the Student Initiation for Student No. %1';
        Text0023Lbl: Label 'Student Initiation process is compeleted for selected students.';
        Text0024Lbl: Label 'Student Initiation process is compeleted for Student No. %1';
        Text0025Lbl: Label 'Do you want to process the SAFI Event for selected Students?';
        Text0026Lbl: Label 'Do you want to process the SAFI Event for Student No. %1';
        Text0027Lbl: Label 'SAFI Event process is compeleted for selected students.';
        Text0028Lbl: Label 'SAFI Event process is compeleted for Student No. %1';
        Text0029Lbl: Label 'Airport Check-in Enabled';
        Text0030Lbl: Label 'Airport Check-in Disabled';
        ShowMapLbl: Label 'Show on Map';
        Social: Boolean;

        SocialSecurity: Text[20];

        SocialSec: Boolean;

        AdmissionGroup: Boolean;
        RegistrarGroup: Boolean;
        ClinicalDetailsGroup: Boolean;
        HousingGroup: Boolean;
        BursarGroup: Boolean;
        EEDBasicSciGroup: Boolean;
        EEDClinicalGroup: Boolean;
        GraduateAffairsGroup: Boolean;
        ExaminationGroup: Boolean;
        GraduationGroup: Boolean;
        FinancialAid1: Boolean;
        Balance: Boolean;
        ShowFerpaDetail: Boolean;
        HideFerpaDetail: Boolean;
        FinancialAidDepartment: Boolean;
        EEDClinical: Boolean;

        EEDChairCanView: Boolean;
        HousingGroupText: Text;
        HousingID: Text;
        ApartmentCategoryCode: Text;
        ApartmentNo: Text;
        RoomNo: Text;
        FatherEnable: Boolean;
        FatherContactNumber: Boolean;
        FatherEmailID: Boolean;
        MothersName: Boolean;
        MotherContactNumber: Boolean;
        MotherEmailID: Boolean;
        GuardianName: Boolean;
        GuardianContactNumber: Boolean;
        GuardianEmailID: Boolean;


    procedure TestCreateStudent() Responsetext: Text
    var
        http_Client: HttpClient;
        http_Headers: HttpHeaders;
        http_content: HttpContent;
        http_Response: HttpResponseMessage;
        http_request: HttpRequestMessage;
        // json_Object: Codeunit "JSON Management";
        // Base64Convert: Codeunit "Base64Convert";
        api_url: text;
        CompInfo: Record "Company Information";
        BodyText: Text;
    begin
        CompInfo.Get();
        http_request.Method('POST');
        api_url := StrSubstNo('http://restapitest.corporateserve.com/api/student');
        http_request.SetRequestUri(api_url);
        //arvhttp_content.clear;
        http_content.GetHeaders(http_Headers);
        // http_Headers.Remove('Content-Type');
        // http_Headers.Add('Content-Type', 'application/json');
        BodyText := '{' +
                                '"StudentID": "' + Format(Rec."No.") + '",' +
                                '"FirstName": "' + Format(Rec."First Name") + '",' +
                                '"LastName": "' + Format(Rec."Last Name") + '",' +
                                '"Email": "' + Format(Rec."E-Mail Address") + '"' +
                                '}';
        http_content.WriteFrom(BodyText);

        http_Headers.Remove('Content-Type');
        http_Headers.Add('Content-Type', 'application/json');
        http_request.Content := http_content;
        http_client.Send(http_request, http_response);
        http_response.Content().ReadAs(responseText);

        // message('%1....%2....%3....%4', http_Response.HttpStatusCode,
        // http_Response.ReasonPhrase, Responsetext, http_Response.IsBlockedByEnvironment);
        Message('2  %1', http_Response.ReasonPhrase());
        Message('3  %1', Responsetext);
        Message('4  %1', http_Response.IsBlockedByEnvironment());
        // http_request.Method('PATCH');
        // http_content.WriteFrom(
        //                         '{' +
        //                         '"StudentID": "' + Rec."No." + '",' +
        //                         '"FirstName": "' + Rec."First Name" + '",' +
        //                         '"LastName": "' + Rec."Last Name" + '",' +
        //                         '"Email": "' + Rec."E-Mail Address" + '"' +
        //                         '}'
    end;

    procedure RoleAndPermission()
    Var
        usersetupapproval: record "Document Approver Users";
    begin
        Bool := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            Bool := false;


        FinancialAid1 := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            FinancialAid1 := false;

        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Financial Aid Department") then
            FinancialAid1 := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                FinancialAid1 := true
            else
                FinancialAid1 := false;

        AdmissionGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::Admissions) then
            AdmissionGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                AdmissionGroup := true
            else
                AdmissionGroup := false;

        RegistrarGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Registrar Department") then
            RegistrarGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                RegistrarGroup := true
            else
                RegistrarGroup := false;


        ClinicalDetailsGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            ClinicalDetailsGroup := false;

        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Clinical Details") then
            ClinicalDetailsGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                ClinicalDetailsGroup := true
            else
                ClinicalDetailsGroup := false;

        HousingGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Residential Services") then
            HousingGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                HousingGroup := true
            else
                HousingGroup := false;

        BursarGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Bursar Department") then
            BursarGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                BursarGroup := true
            else
                BursarGroup := false;

        EEDBasicSciGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDBasicSciGroup := false;

        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"EED Pre-Clinical") then
            EEDBasicSciGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                EEDBasicSciGroup := true
            else
                EEDBasicSciGroup := false;

        EEDClinicalGroup := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN
            EEDClinicalGroup := false;

        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"EED Clinical") then
            EEDClinicalGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                EEDClinicalGroup := true
            else
                EEDClinicalGroup := false;

        GraduateAffairsGroup := true;
        GAffairsBoolean := true;
        IF Rec."Global Dimension 1 Code" = '9100' THEN begin
            GraduateAffairsGroup := false;
            GAffairsBoolean := False;
        end;

        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::"Graduate Affairs") then begin
            GraduateAffairsGroup := true;
            GAffairsBoolean := false;
        end else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then begin
                GraduateAffairsGroup := true;
                GAffairsBoolean := false;
            end else begin
                GraduateAffairsGroup := false;
                if NOT usersetupapprover.Get(UserId(), usersetupapprover."Department Approver Type"::"EED Clinical") then // Need to hide some buttons for eed clinical but this boolean is set on visibility
                    GAffairsBoolean := true
                else
                    GAffairsBoolean := false;
            end;

        ExaminationGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::Examination) then
            ExaminationGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                ExaminationGroup := true
            else
                ExaminationGroup := false;

        GraduationGroup := true;
        if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::Graduation) then
            GraduationGroup := true
        else
            if usersetupapproval.get(Userid(), usersetupapproval."Department Approver Type"::" ") then
                GraduationGroup := true
            else
                GraduationGroup := false;


    end;

    procedure RoleAndPermissionNew()
    var
        UserSetupApprover: Record "Document Approver Users";
    begin
        Balance := true;

        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId);
        if usersetupapprover.FindFirst() then begin
            if (usersetupapprover."Department Approver Type" IN [usersetupapprover."Department Approver Type"::"Financial Aid Department", usersetupapprover."Department Approver Type"::" ",
                                                                usersetupapprover."Department Approver Type"::BackOffice, usersetupapprover."Department Approver Type"::"Bursar Department"]) then
                Balance := true
            else
                Balance := false;
        end;

    end;

    local procedure BlankDates()
    begin
        //CSPL-00307-17-05-2022
        IF (Rec."Visa Issued Date" <> 0D) AND (Rec."Visa Issued Date" = 19000101D) then
            Rec."Visa Issued Date" := 0D;
        IF (Rec."Date of Birth" <> 0D) AND (Rec."Date of Birth" = 19000101D) then
            Rec."Date of Birth" := 0D;
        IF (Rec."Visa Expiry Date" <> 0D) AND (Rec."Visa Expiry Date" = 19000101D) then
            Rec."Visa Expiry Date" := 0D;
        IF (Rec."OLR Completed Date" <> 0D) AND (Rec."OLR Completed Date" = 19000101D) then
            Rec."OLR Completed Date" := 0D;
        IF (Rec."Visa Extension Date" <> 0D) AND (Rec."Visa Extension Date" = 19000101D) then
            Rec."Visa Extension Date" := 0D;
        IF (Rec."Immigration Issuance Date" <> 0D) AND (Rec."Immigration Issuance Date" = 19000101D) then
            Rec."Immigration Issuance Date" := 0D;
        IF (Rec."Immigration Expiration Date" <> 0D) AND (Rec."Immigration Expiration Date" = 19000101D) then
            Rec."Immigration Expiration Date" := 0D;
    end;

}

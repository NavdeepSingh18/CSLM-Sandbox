page 50692 "Student Registration Card"
{
    PageType = Card;
    UsageCategory = None;
    Editable = false;
    DelayedInsert = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Student Registration-CS";
    DataCaptionFields = "Student No", "Student Name";
    Caption = 'Student Stage Wise Registration Card';

    layout
    {
        area(content)
        {
            group("Stage Details")
            {
                field("Basic Information Stage Status"; Rec."Stage Basic Information")
                {
                    ApplicationArea = all;

                }
                field("Basic Information Stage Completion Date"; Rec."Stage Basic Info Date")
                {
                    ApplicationArea = All;

                }
                field("Basic Information Stage Completion Time"; Rec."Stage Basic Info Time")
                {
                    ApplicationArea = All;

                }


                field("Housing Stage Status"; Rec."Stage Housing")
                {
                    ApplicationArea = all;


                }
                field("Housing Stage Completion Date"; Rec."Stage Housing Date")
                {
                    ApplicationArea = All;

                }
                field("Housing Stage Completion Time"; Rec."Stage Housing Time")
                {
                    ApplicationArea = All;


                }

                field("Insurance Stage Status"; Rec."Stage Insurance")
                {
                    ApplicationArea = All;



                }
                field("Insurance Stage Completion Date"; Rec."Stage Insurance Date")
                {
                    ApplicationArea = All;

                }
                field("Insurance Stage Completion Time"; Rec."Stage Insurance Time")
                {
                    ApplicationArea = All;

                }

                field("FERPA Stage Status"; Rec."Stage FERPA")
                {
                    ApplicationArea = All;



                }
                field("FERPA Stage Completion Date"; Rec."Stage FERPA Date")
                {
                    ApplicationArea = All;

                }
                field("FERPA Stage Completion Time"; Rec."Stage FERPA Time")
                {
                    ApplicationArea = All;

                }
                Field("FERPA Release"; Rec."FERPA Release")
                {
                    ApplicationArea = All;
                }

                field("Media Release Stage Status"; Rec."Stage Media Release")
                {
                    ApplicationArea = All;

                }
                field("Media Release Stage Completion Date"; Rec."Stage Media Date")
                {
                    ApplicationArea = All;

                }
                field("Media Release Stage Completion Time"; Rec."Stage Media Time")
                {
                    ApplicationArea = All;

                }



                field("Agreements Stage Status"; Rec."Stage Agreements")
                {
                    ApplicationArea = All;

                }
                field("Agreements Stage Completion Date"; Rec."Stage Agreements Date")
                {
                    ApplicationArea = All;

                }
                field("Agreements Stage Completion Time"; Rec."Stage Agreements Time")
                {
                    ApplicationArea = All;

                }

                field("Financial Aid Stage Status"; Rec."Stage Financial Aid")
                {
                    ApplicationArea = All;
                    //Visible = CueVisible;
                    Visible = False;

                }
                field("Financial Aid Stage Completion Date"; Rec."Stage Financial Aid Date")
                {
                    ApplicationArea = All;
                    //Visible = CueVisible;
                    Visible = False;

                }
                field("Financial Aid Stage Completion Time"; Rec."Stage Financial Aid Time")
                {
                    ApplicationArea = All;
                    //Visible = CueVisible;
                    Visible = False;

                }

                field("Bursar Stage Status"; Rec."Stage Bursar")
                {
                    ApplicationArea = All;

                }
                field("Bursar Stage Completion Date"; Rec."Stage Bursar Date")
                {
                    ApplicationArea = All;

                }
                field("Bursar Stage Completion Time"; Rec."Stage Bursar Time")
                {
                    ApplicationArea = All;

                }

                field("Confirmation Stage Status"; Rec."Stage Confirmation")
                {
                    ApplicationArea = All;

                }
                field("Confirmation Stage Completion Date"; Rec."Stage Confirmation Date")
                {
                    ApplicationArea = All;
                }
                field("Confirmation Stage Completion Time"; Rec."Stage Confirmation Time")
                {
                    ApplicationArea = All;

                }

                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;

                }
                field("OLR Completed Date"; Rec."OLR Completed Date")
                {
                    ApplicationArea = All;

                }
                field("OLR Completed Time"; Rec."OLR Completed Time")
                {

                    ApplicationArea = All;

                }
            }
            group("Basic Information")
            {

                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }

                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Maiden Name"; Rec."Maiden Name")
                {
                    ApplicationArea = All;
                }
                field("Alternate E-Mail Address"; Rec."Alternate E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Street Address"; Rec."Street Address")
                {
                    ApplicationArea = All;
                }
                Field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Address 3"; Rec."Address 3")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(Citizenship; Rec.Citizenship)
                {
                    ApplicationArea = All;
                }
                field(Ethnicity; Rec.Ethnicity)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = all;
                }
                field("Apply for Insurance"; Rec."Apply for Insurance")
                {
                    ApplicationArea = All;
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
                    Caption = 'RelationShip';
                }
                field("Emergency Contact Phone No."; Rec."Emergency Contact Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }
                field("Emergency Contact Phone No. 2"; Rec."Emergency Contact Phone No. 2")
                {
                    ApplicationArea = All;
                    Caption = 'Phone No. 2';
                }
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
                    Caption = 'Address';
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
            // group("Resident Address (Antigua)")
            // {
            //     field("Resident Address"; Rec."Resident Address")
            //     { ApplicationArea = all; Rec.}
            //     field("Resident Country"; Rec."Resident Country")
            //     { ApplicationArea = all; Rec.}
            //     field("Resident State"; Rec."Resident State")
            //     { ApplicationArea = all; Rec.}
            //     field("Resident City"; Rec."Resident City")
            //     { ApplicationArea = all; Rec.}

            //     field("Resident Zip Code"; Rec."Resident Zip Code")
            //     { ApplicationArea = all; Rec.}
            //     field("Resident Plan"; Rec."Resident Plan")
            //     { ApplicationArea = all; Rec.}
            // }
            //SD-SN-03-Dec-2020 -
            group("Passport Details")
            {
                field("Student Passport Full Name"; Rec."Student Passport Full Name")
                {
                    ApplicationArea = All;
                    Caption = 'Passport Full Name';
                }
                field("Pass Port No. 1"; Rec."Pass Port No. 1")
                {
                    ApplicationArea = all;
                    Caption = 'Passport No.';
                }
                field("Pass Port Issued Date 1"; Rec."Pass Port Issued Date 1")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Issued Date';
                }
                field("Pass Port Issued By 1"; Rec."Pass Port Issued By 1")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Issued By';
                }
                field("Pass Port Expiry Date 1"; Rec."Pass Port Expiry Date 1")
                {
                    ApplicationArea = all;
                    Caption = 'Passport Expiry Date';
                }
                field("Visa No."; Rec."Visa No.")
                {
                    ApplicationArea = all;
                }
                field("Visa Issued Date"; Rec."Visa Issued Date")
                {
                    ApplicationArea = all;
                }
                field("Visa Expiry Date"; Rec."Visa Expiry Date")
                {
                    ApplicationArea = all;
                }
                field("Visa Extension Date"; Rec."Visa Extension Date")
                {
                    ApplicationArea = all;
                }
            }
            group("Agreement Details")
            {
                field("Lease Agreement"; Rec."Lease Agreement")
                {
                    ApplicationArea = all;
                }
                field("Media Release Sign-off"; Rec."Media Release Sign-off")
                {
                    caption = 'Media Release Acceptance';
                    ApplicationArea = All;
                }
                field("Insurance Agreement"; Rec."Insurance Agreement")
                {
                    ApplicationArea = All;
                }
                field("Bursar Agreement"; Rec."Bursar Agreement")
                {
                    ApplicationArea = All;
                }
                field("Registrar Agreement"; Rec."Registrar Agreement")
                {
                    ApplicationArea = All;
                }
                field("Title_IV Agreement"; Rec."Title_IV Agreement")
                {
                    ApplicationArea = All;
                }
                field("Release Agreement"; Rec."Release Agreement")
                {
                    ApplicationArea = All;
                }
                field("Residential Network Agreement"; Rec."Residential Network Agreement")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Check Agmt"; Rec."Emergency Contact Check Agmt")
                {
                    ApplicationArea = All;
                }
                Field("MOU Agreement"; Rec."MOU Agreement")
                {
                    ApplicationArea = All;
                }

            }


        }
        // area(factboxes)
        // {

        //     part("OLR Stages FactBox"; "OLR Stages FactBox")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "Student No" = FIELD("Student No"), "Course Code" = field("Course Code"), "Academic Year" = field("Academic Year"), Semester = field(Semester), Term = field(Term);
        //     }

        // }

    }
    var
        UserSetup: Record "User Setup";
        CueVisible: Boolean;

    trigger OnOpenPage();
    begin
        UserSetup.Get(UserId());

        if (UserSetup."Global Dimension 1 Code" = '9000') then
            CueVisible := true
        else
            CueVisible := false;
    end;

    trigger OnAfterGetRecord()
    begin
        // BlankDates();
    end;
    /*
        local procedure BlankDates()
        begin
            //CSPL-00307-17-05-2022
            IF ("Visa Issued Date" <> 0D) AND ("Visa Issued Date" = 19000101D) then
                "Visa Issued Date" := 0D;
            IF ("Date of Birth" <> 0D) AND ("Date of Birth" = 19000101D) then
                "Date of Birth" := 0D;
            IF ("Stage FERPA Date" <> 0D) AND ("Stage FERPA Date" = 19000101D) then
                "Stage FERPA Date" := 0D;
            IF ("Stage Media Date" <> 0D) AND ("Stage Media Date" = 19000101D) then
                "Stage Media Date" := 0D;
            IF ("Visa Expiry Date" <> 0D) AND ("Visa Expiry Date" = 19000101D) then
                "Visa Expiry Date" := 0D;
            IF ("Stage Bursar Date" <> 0D) AND ("Stage Bursar Date" = 19000101D) then
                "Stage Bursar Date" := 0D;
            IF ("OLR Completed Date" <> 0D) AND ("OLR Completed Date" = 19000101D) then
                "OLR Completed Date" := 0D;
            IF ("Stage Housing Date" <> 0D) AND ("Stage Housing Date" = 19000101D) then
                "Stage Housing Date" := 0D;
            IF ("Visa Extension Date" <> 0D) AND ("Visa Extension Date" = 19000101D) then
                "Visa Extension Date" := 0D;
            IF ("Stage Insurance Date" <> 0D) AND ("Stage Insurance Date" = 19000101D) then
                "Stage Insurance Date" := 0D;
            IF ("Pass Port Expiry Date 1" <> 0D) AND ("Pass Port Expiry Date 1" = 19000101D) then
                "Pass Port Expiry Date 1" := 0D;
            IF ("Pass Port Expiry Date 2" <> 0D) AND ("Pass Port Expiry Date 2" = 19000101D) then
                "Pass Port Expiry Date 2" := 0D;
            IF ("Pass Port Expiry Date 3" <> 0D) AND ("Pass Port Expiry Date 3" = 19000101D) then
                "Pass Port Expiry Date 3" := 0D;
            IF ("Pass Port Issued Date 1" <> 0D) AND ("Pass Port Issued Date 1" = 19000101D) then
                "Pass Port Issued Date 1" := 0D;
            IF ("Pass Port Issued Date 2" <> 0D) AND ("Pass Port Issued Date 2" = 19000101D) then
                "Pass Port Issued Date 2" := 0D;
            IF ("Pass Port Issued Date 3" <> 0D) AND ("Pass Port Issued Date 3" = 19000101D) then
                "Pass Port Issued Date 3" := 0D;
            IF ("Stage Agreements Date" <> 0D) AND ("Stage Agreements Date" = 19000101D) then
                "Stage Agreements Date" := 0D;
            IF ("Stage Basic Info Date" <> 0D) AND ("Stage Basic Info Date" = 19000101D) then
                "Stage Basic Info Date" := 0D;
            IF ("Stage Confirmation Date" <> 0D) AND ("Stage Confirmation Date" = 19000101D) then
                "Stage Confirmation Date" := 0D;
            IF ("Stage Financial Aid Date" <> 0D) AND ("Stage Financial Aid Date" = 19000101D) then
                "Stage Financial Aid Date" := 0D;
            IF ("Immigration Issuance Date" <> 0D) AND ("Immigration Issuance Date" = 19000101D) then
                "Immigration Issuance Date" := 0D;
            IF ("Immigration Expiration Date" <> 0D) AND ("Immigration Expiration Date" = 19000101D) then
                "Immigration Expiration Date" := 0D;
            IF ("Immigration Application Date" <> 0D) AND ("Immigration Application Date" = 19000101D) then
                "Immigration Application Date" := 0D;
        end;
        */
}
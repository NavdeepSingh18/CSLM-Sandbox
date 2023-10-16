page 50732 HousingAppBufferList
{

    PageType = API;
    Caption = 'HousingAppBufferAPI';
    APIPublisher = 'HousingAppBufferAPI';
    APIGroup = 'HousingAppBufferAPI';
    EntityName = 'HousingAppBufferAPI';
    EntitySetName = 'HousingAppBufferAPI';
    SourceTable = "Housing Application Buffer";
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(applicationNo; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field(studentNo; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(withSpouse; Rec."With Spouse")
                {
                    ApplicationArea = All;
                }
                field(housingPref1; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;
                }
                field("housinggroupPref1"; Rec."Housing Group Pref.1")
                {
                    ApplicationArea = All;
                }
                field("roomcategoryPref1"; Rec."Room Category Pref.1")
                {
                    ApplicationArea = All;
                }
                field(housingPref2; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;
                }
                field("housinggroupPref2"; Rec."Housing Group Pref.2")
                {
                    ApplicationArea = All;
                }
                field("roomcategoryPref2"; Rec."Room Category Pref.2")
                {
                    ApplicationArea = All;
                }
                field(housingPref3; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;
                }
                field("housinggroupPref3"; Rec."Housing Group Pref.3")
                {
                    ApplicationArea = All;
                }
                field("roomcategoryPref3"; Rec."Room Category Pref.3")
                {
                    ApplicationArea = All;
                }
                field(preferenceRemarks; Rec."Preference Remarks")
                {
                    ApplicationArea = All;
                }
                field(roommatenamePref; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;
                }
                field(roommateemailPref; Rec."Room Mate Email Pref")
                {
                    ApplicationArea = All;
                }
                field(deleteAPP; Rec."Delete Application")
                {
                    ApplicationArea = all;
                }
                Field(AcademicYEar; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                Field(seMester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field(tErm; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(meDicalconDition; Rec."Medical Condition")
                {
                    ApplicationArea = All;
                }
                field(traVelwithSpouse; Rec."Traveling With Spouse")
                {
                    ApplicationArea = All;
                }
                field(traVelSpousechILd; Rec."Travel Spouse & Child")
                {
                    ApplicationArea = All;
                }
                field(traVelserViceaniMal; Rec."Travel Ser. Animal")
                {
                    ApplicationArea = All;
                }
                field(otHer; Rec.Other)
                {
                    ApplicationArea = All;
                }
                field(otHerdesCription; Rec."Other Description")
                {
                    ApplicationArea = All;
                }
                field(speCialrooMatepref; Rec."Special Roommate Preference")
                {
                    ApplicationArea = All;
                }
                field(diSabiliTy; Rec.Disability)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        HousingApplicationRec: Record "Housing Application";
        HostelApplicationRec: Record "Housing Application";
        HousingApplicationBufferRec: Record "Housing Application Buffer";
        RecOptOut: Record "Opt Out";
        StudentMasterRec: Record "Student Master-CS";
        HousingMailCod: codeunit "Hosusing Mail";
        Results: Text[50];
        ApplicationFound: Boolean;

    begin
        // if "Application No." = '' then
        //     Error('Application No. is mandatory');

        if not Rec."Delete Application" then begin
            If Rec."Housing Pref. 1" = '' then
                Error('Housing Preference 1 is mandatory');
            If Rec."Room Category Pref.1" = '' then
                Error('Apartment Preference 1 is mandatory');
            If Rec."Housing Group Pref.1" = '' then
                Error('Housing Group Preference 1 is mandatory');
        end
        else begin
            if Rec."Application No." = '' then
                Error('Application No. is mandatory in case of deletion');
        end;

        if Rec."Application No." <> '' then begin
            if Rec."Delete Application" then begin
                HousingApplicationRec.reset();
                if HousingApplicationRec.Get(Rec."Application No.") then
                    HousingApplicationRec.Delete(true);

            end
            else begin
                HousingApplicationBufferRec.Reset();
                HousingApplicationBufferRec.SetRange("Application No.", Rec."Application No.");
                HousingApplicationBufferRec.SetRange("Student No.", Rec."Student No.");
                if HousingApplicationBufferRec.FindLast() then
                    Rec."Line No." := HousingApplicationBufferRec."Line No." + 10000
                Else
                    Rec."Line No." := 10000;

                Rec."Entry From Salesforce" := true;
                HousingApplicationRec.reset();
                if HousingApplicationRec.Get(Rec."Application No.") then begin
                    if HousingApplicationRec."Student No." <> Rec."Student No." then
                        Error('Housing Application No. %1 does not belong to Student No. %2', HousingApplicationRec."Application No.", Rec."Student No.");
                    if HousingApplicationRec.Status <> HousingApplicationRec.Status::"Pending for Approval" then
                        Error('Housing Application No. %1 cannot be modified as its Status is now %2', HousingApplicationRec."Application No.", HousingApplicationRec.Status);
                    HousingApplicationRec.validate("With Spouse", Rec."With Spouse");
                    HousingApplicationRec.validate("Housing Pref. 1", Rec."Housing Pref. 1");
                    HousingApplicationRec.validate("Housing Group Pref.1", Rec."Housing Group Pref.1");
                    HousingApplicationRec.validate("Room Category Pref.1", Rec."Room Category Pref.1");
                    HousingApplicationRec.validate("Housing Pref. 2", Rec."Housing Pref. 2");
                    HousingApplicationRec.validate("Housing Group Pref.2", Rec."Housing Group Pref.2");
                    HousingApplicationRec.validate("Room Category Pref.2", Rec."Room Category Pref.2");
                    HousingApplicationRec.validate("Housing Pref. 3", Rec."Housing Pref. 3");
                    HousingApplicationRec.validate("Housing Group Pref.3", Rec."Housing Group Pref.3");
                    HousingApplicationRec.validate("Room Category Pref.3", Rec."Room Category Pref.3");
                    HousingApplicationRec.validate("Preference Remarks", Rec."Preference Remarks");
                    HousingApplicationRec.validate("Room Mate Name Pref", Rec."Room Mate Name Pref");
                    HousingApplicationRec.validate("Room Mate Email Pref", Rec."Room Mate Email Pref");
                    HousingApplicationRec."Academic Year" := Rec."Academic Year";
                    HousingApplicationRec.Semester := Rec.Semester;
                    HousingApplicationRec.Term := Rec.Term;
                    HousingApplicationRec."Medical Condition" := Rec."Medical Condition";
                    HousingApplicationRec.Disability := Rec.Disability;//FALL 2023 OLR Changes
                    HousingApplicationRec."Traveling With Spouse" := Rec."Traveling With Spouse";
                    HousingApplicationRec."Travel Spouse & Child" := Rec."Travel Spouse & Child";
                    HousingApplicationRec."Travel Ser. Animal" := Rec."Travel Ser. Animal";
                    HousingApplicationRec.Other := Rec.Other;
                    HousingApplicationRec."Other Description" := Rec."Other Description";
                    HousingApplicationRec."Special Roommate Preference" := Rec."Special Roommate Preference";
                    HousingApplicationRec.Modify(true);
                end
                else
                    Error('Housing Application No. %1 does not exist', Rec."Application No.");
            end;
        end;

        if Rec."Application No." = '' then begin
            ApplicationFound := false;
            StudentMasterRec.Get(Rec."Student No.");
            HostelApplicationRec.RESET();
            HostelApplicationRec.SETRANGE("Student No.", Rec."Student No.");
            HostelApplicationRec.SetRange(Semester, Rec.Semester);
            HostelApplicationRec.SetRange("Academic Year", Rec."Academic Year");
            HostelApplicationRec.SetRange(Term, Rec.Term);
            HostelApplicationRec.Setfilter(Status, '%1|%2', HostelApplicationRec.Status::"Pending for Approval", HostelApplicationRec.Status::Approved);
            IF HostelApplicationRec.FindLast() then begin
                ApplicationFound := True;
                Rec."Application No." := HostelApplicationRec."Application No.";
                HousingApplicationBufferRec.Reset();
                HousingApplicationBufferRec.SetRange("Application No.", Rec."Application No.");
                HousingApplicationBufferRec.SetRange("Student No.", Rec."Student No.");
                if HousingApplicationBufferRec.FindLast() then
                    Rec."Line No." := HousingApplicationBufferRec."Line No." + 10000
                Else
                    Rec."Line No." := 10000;
            end;

            RecOptOut.Reset();
            RecOptOut.SetRange("Student No.", Rec."Student No.");
            RecOptOut.SetRange("Academic Year", Rec."Academic Year");
            RecOptOut.SetRange(Semester, Rec.Semester);
            RecOptOut.SetRange(Term, Rec.Term);
            RecOptOut.Setrange(RecOptOut."Application Type", RecOptOut."Application Type"::"Housing Wavier");
            IF RecOptOut.FindFirst() then
                Error('Housing Application cannot be created as Housing Waiver Application already exists for this Student');

            If not ApplicationFound then begin
                Results := HousingMailCod.SalesforceHousingApplicationInsert(Rec."Student No.",
                Rec."With Spouse",
                Rec."Housing Pref. 1",
                Rec."Housing Pref. 2",
                Rec."Housing Pref. 3",
                Rec."Room Category Pref.1",
                Rec."Room Category Pref.2",
                Rec."Room Category Pref.3",
                Rec."Housing Group Pref.1",
                Rec."Housing Group Pref.2",
                Rec."Housing Group Pref.3",
                Rec."Preference Remarks",
                Rec."Room Mate Name Pref",
                Rec."Room Mate Email Pref", true, 0D, 0D, 0T, '', '', 0D, Rec."Academic Year", Rec.Semester, Rec.Term, Rec."Medical Condition", Rec.Disability
                , Rec."Traveling With Spouse", Rec."Travel Spouse & Child", Rec."Travel Ser. Animal", Rec.Other, Rec."Other Description", Rec."Special Roommate Preference");

                if CopyStr(Results, 1, 7) = 'Success' then
                    Rec."Application No." := CopyStr(Results, 9, (StrLen(Results)))
                else
                    Error('Could not Insert the Housing Application');
            end;

        end;
        Rec."Application Inserted Date" := Today();
    end;
}

report 50222 "LGS Letter"
{
    Caption = 'LGS Letter';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/LGS Letter.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")

        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Last Name", "Start Date", Status;
            column(EntyNo; "Roster Ledger Entry"."Entry No.")
            {

            }
            column(Student_Name; StudentMaster."Student Name")
            {

            }
            column(RotationStartDate; "Roster Ledger Entry"."Start Date")
            {

            }
            column(RotationEndDate; "Roster Ledger Entry"."End Date")
            {

            }
            column(Hospital; "Roster Ledger Entry"."Hospital Name")
            {

            }

            column(Clerkship; "Roster Ledger Entry"."Rotation Description")
            {

            }
            column(CompnyPic; EducationSetup_Rec."Collage of Medicine Logo")
            {

            }
            column(AcademicYear; AcademicYear)
            {

            }
            column(CompanyName; CompanyInfo.Name)
            {

            }
            column(ComAddrs; CompanyInfo.Address + ' ' + CompanyInfo."Address 2")
            {

            }
            column(CompanyCity; CompanyInfo.City)
            {

            }

            column(CompnayZipCode; CompanyInfo."Post Code")
            {

            }

            column(CompanyState; CompanyInfo."Country/Region Code")
            {

            }

            column(CompanyHomePage; CompanyInfo."Home Page")
            {

            }
            column(InstituteName; EducationSetup_Rec."Institute Name")
            {

            }
            column(ContectAdd1; ContectAdd1)
            {

            }
            column(ContectAdd2; ContectAdd2)
            {

            }
            column(ContectAdd3; ContectAdd3)
            {

            }
            column(ContectAdd4; ContectAdd4)
            {

            }
            column(ContectAdd5; ContectAdd5)
            {

            }
            column(Signature; EducationSetup_Rec."Associate Vice President")
            {

            }
            column(HospitalAddress1; HospitalAddress1)
            {

            }
            column(HospitalAddress2; HospitalAddress2)
            {

            }
            column(RotationPrintDate; today)
            {

            }

            trigger OnPreDataItem()
            var
            begin
                if UserSetup.Get(UserId) then;
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Collage of Medicine Logo", "Associate Vice President");
            end;

            trigger OnAfterGetRecord()
            var

                LSemester: Code[20];
            begin
                CompanyInfo.Get();
                SubjectGroupCode := '';
                SubjectMasterCS.Reset();
                SubjectMasterCS.SetRange(Code, "Course Code");
                if SubjectMasterCS.FindFirst() then
                    SubjectGroupCode := SubjectMasterCS."Subject Group";

                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then;

                ContectAdd1 := '';
                ContectAdd2 := '';
                if "Roster Ledger Entry"."Clerkship Type" in
                ["Roster Ledger Entry"."Clerkship Type"::Elective, "Roster Ledger Entry"."Clerkship Type"::"FM1/IM1"] then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetFilter("Elective Only", '%1', true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Pediatrics') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetFilter("Paediatrics", '%1', true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Surgery') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetFilter("Surgery", '%1', true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Obstetrics and Gynecology') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetFilter("Obstetrics and Gynecology", '%1', true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Family Medicine') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetRange("Family Medicine", true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Internal Medicine') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetRange("Internal Medicine", true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;
                if StrPos("Roster Ledger Entry"."Course Description", 'Psychiatry') <> 0 then begin
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetRange("No.", "Hospital ID");
                    ContactBusinessRelation.SetRange("Psychiatry", true);
                    if ContactBusinessRelation.FindFirst() then begin
                        ContectAdd1 := ContactBusinessRelation.Name;
                        if ContactBusinessRelation.Title <> ContactBusinessRelation.Title::" " then
                            ContectAdd1 := Format(ContactBusinessRelation.Title) + ' ' + ContactBusinessRelation.Name;
                        ContectAdd2 := ContactBusinessRelation."Last Name";
                    end;
                end;


                LSemester := Semester;

                if Semester = '' then
                    LSemester := StudentMaster.Semester;

                if LSemester = 'BSIC' then
                    AcademicYear := 'BSIC';
                if LSemester = 'CLN5' then
                    AcademicYear := '3rd';
                if LSemester = 'CLN6' then
                    AcademicYear := '3rd';
                if LSemester = 'CLN7' then
                    AcademicYear := '4th';
                if LSemester = 'CLN8' then
                    AcademicYear := '4th';

                HospitalMaster.Reset();
                if HospitalMaster.Get("Hospital ID") then begin
                    HospitalAddress1 := HospitalMaster.Address + ' ' + HospitalMaster."Address 2";
                    // HospitalAddress2 := HospitalMaster.City + ' ' + HospitalMaster."State Code" + ' ' + HospitalMaster."Post Code";
                end;


                // if StrPos("Roster Ledger Entry"."Course Description", 'Elective Only') <> 0 then
                //     ContactBusinessRelation.Reset();
                // ContactBusinessRelation.SetRange("Elective Only", true);
                // if ContactBusinessRelation.FindFirst() then
                //     repeat
                //         Contact.Reset();
                //         Contact.SetRange("No.", ContactBusinessRelation."Contact No.");
                //         Contact.SetRange("LGS Core Subject", SubjectGroupCode);
                //         if Contact.FindFirst() then begin
                //             ContectAdd1 := Contact.Name;
                //             ContectAdd2 := Contact.Address;
                //             ContectAdd3 := Contact."Address 2";
                //             ContectAdd4 := Contact."Post Code" + '-' + Contact.City;
                //             if StateRec.Get(Contact.State) then;
                //             ContectAdd5 := StateRec.Description + ' ' + Contact."Country/Region Code";
                //         end;
                //     until ContactBusinessRelation.Next() = 0;


                // RosterSchedulingHeader.Reset();
                // RosterSchedulingHeader.SetRange("Rotation ID", "Rotation ID");
                // if RosterSchedulingHeader.FindFirst() then
                //     if RosterSchedulingHeader."Preceptor Contact No." <> '' then begin
                //         Contact.Reset();
                //         Contact.SetRange("No.", RosterSchedulingHeader."Preceptor Contact No.");
                //         if Contact.FindFirst() then begin
                //             ContectAdd1 := Contact.Name;
                //             ContectAdd2 := Contact.Address;
                //             ContectAdd3 := Contact."Address 2";
                //             ContectAdd4 := Contact."Post Code" + '-' + Contact.City;
                //             if StateRec.Get(Contact.State) then;
                //             ContectAdd5 := StateRec.Description + ' ' + Contact."Country/Region Code";
                //         end else
                //             ContectAdd1 := RosterSchedulingHeader."Preceptor Name";

            end;
            // end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(ActionName)
                // {
                //     ApplicationArea = All;

                // }
            }
        }
    }

    var
        StudentMaster: Record "Student Master-CS";
        EducationSetup_Rec: Record "Education Setup-CS";
        UserSetup: Record "User Setup";
        CompanyInfo: Record "Company Information";
        SubjectMasterCS: Record "Subject Master-CS";
        // RosterSchedulingHeader: Record "Roster Scheduling Header";
        ContactBusinessRelation: Record "Business Contact Relation";
        // HospitalMaster: Record Vendor;
        HospitalMaster: Record Vendor;
        SubjectGroupCode: Text;
        ContectAdd1: text;
        ContectAdd2: text;
        ContectAdd3: text;
        ContectAdd4: text;
        ContectAdd5: text;
        AcademicYear: Text;
        HospitalAddress1: Text;
        HospitalAddress2: Text;


}
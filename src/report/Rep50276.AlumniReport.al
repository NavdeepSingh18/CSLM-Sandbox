report 50276 "Alumni Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            RequestFilterFields = "Original Student No.";
            DataItemTableView = sorting("Original Student No.") order(ascending) where(Status = filter('GRAD'));

            dataitem(Residency; Residency)
            {
                DataItemLink = "Enrollment No." = field("Enrollment No.");
                DataItemTableView = where("Residency Type" = filter('YES'));
                trigger OnPreDataItem()
                begin
                    Residency.SetCurrentKey("Residency Year");
                    Residency.Ascending(false);
                    PlacementActualOrder := 0;
                    PlacementFieldOrder := 0;
                    ResidentYearFilter := '';
                    ResidentYearFilter1 := '';
                    ResidentYearFilter2 := '';
                end;

                trigger OnAfterGetRecord()
                var

                    YearCount: Integer;
                    EthnicityCode: Text;
                    PlacementTypeCount: Integer;
                    EntryNo: Integer;
                    globalhealthtrack: Text;
                    fiurotations: text;
                    residencyTxt: text;
                    premed: Text;
                    premed1: Text;
                    premed2: Text;
                    ResidencySpecialty: Text;
                    hospitalname: Text;
                    hospitalcity: Code[20];
                    hospitalstate: Code[20];
                    hospitalcountry: Text;
                    studentstatus: Code[20];
                    studentcountry: Text;
                    residencystatus: text;
                    graduationyear: Text;
                    residencyorder: Integer;
                    residencyorder2: Integer;
                    residencyorderlast: Text;
                    nationalityname: Text;
                    residencystate: Text;
                    statedesc: text;
                    placementtype: text;
                    StringPOs: Integer;


                begin


                    If ResidentYearFilter <> Residency."Residency Year" then begin
                        YearCount := 0;
                        Residency_lRec.Reset();
                        Residency_lRec.SetRange("Enrollment No.", Residency."Enrollment No.");
                        Residency_lRec.SetRange("Residency Year", Residency."Residency Year");
                        Residency_lRec.SetRange("Residency Type", 'YES');
                        YearCount := Residency_lRec.Count();

                        IF YearCount = 1 then begin
                            TempRecord_gRec.Reset();
                            IF TempRecord_gRec.FindLast() then
                                EntryNo := TempRecord_gRec."Entry No" + 1
                            Else
                                EntryNo := 1;



                            TempRecord_gRec.Init();
                            TempRecord_gRec."Entry No" := EntryNo;
                            TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                            TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                            TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                            TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                            TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);

                            country.Reset();
                            country.SetRange(Code, "Student Master-CS".Nationality);
                            if country.FindFirst() then
                                TempRecord_gRec.Field14 := country.Nationality
                            else
                                TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                            EthnicityCode := '';
                            studentEthnicity.Reset();
                            studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                            if studentEthnicity.findset() then
                                repeat
                                    if EthnicityCode = '' then
                                        EthnicityCode := studentEthnicity."Ethnicity Name"
                                    else
                                        EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                until studentEthnicity.Next() = 0;

                            TempRecord_gRec.Field51 := EthnicityCode;

                            Evaluate(TempRecord_gRec.Program, Residency."Residency Year");
                            TempRecord_gRec.Field38 := Residency."Residency Placement Type";
                            TempRecord_gRec.Field39 := Residency."Residency Specialty";
                            TempRecord_gRec.Field40 := Residency."Residency Status";

                            PlacementActualOrder += 1;
                            TempRecord_gRec.Field32 := PlacementActualOrder;

                            TempRecord_gRec.Field44 := Residency."Hospital Name";
                            TempRecord_gRec.Field46 := Residency."Hospital City";
                            TempRecord_gRec.Field47 := Residency."Hospital State";

                            IF (Strpos(Residency."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency."Residency Placement Type", 'PRELIM') > 0) or (Strpos(Residency."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency."Residency Specialty", 'Prelim') > 0) then
                                TempRecord_gRec."Residency Preliminary" := 'Yes'
                            else
                                TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                            TempRecord_gRec."Licence State" := LicenseTrackingState;
                            TempRecord_gRec."Licence Type" := LicenseType;

                            country.Reset();
                            country.SetRange(Code, Residency."Hospital Country");
                            if country.FindFirst() then
                                TempRecord_gRec.Field48 := country.Name;

                            TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                            TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                            TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                            TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                            TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                            TempRecord_gRec.Field54 := "Student Master-CS".City;

                            staterec.Reset();
                            staterec.SetRange(code, "Student Master-CS".State);
                            staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                            if staterec.FindFirst() then
                                TempRecord_gRec.Field58 := staterec.Description;

                            TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                            country.Reset();
                            country.SetRange(Code, "Student Master-CS"."Country Code");
                            IF country.FindFirst() then
                                TempRecord_gRec.Field59 := country.Name;

                            TempRecord_gRec.Field60 := "Student Master-CS".Status;
                            IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                TempRecord_gRec."Enrollment No." := 'Yes'
                            Else
                                TempRecord_gRec."Enrollment No." := '';

                            Clear(studenthonors);
                            studenthonors.Reset();
                            studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            if studenthonors.FindFirst() then;

                            fiurotations := '';
                            graduationyear := '';
                            studentdegree.Reset();
                            studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                            studentdegree.SetRange("Degree Code", 'DOC');
                            if studentdegree.FindFirst() then begin
                                graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                rosterledgerentry.Reset();
                                rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                if rosterledgerentry.FindFirst() then begin
                                    if rosterledgerentry.count > 5 then
                                        fiurotations := 'Yes'
                                    else
                                        fiurotations := '';
                                end;
                            end;

                            premed2 := '';
                            premed1 := '';
                            studentgroup.Reset();
                            studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                            Studentgroup.SetRange("Groups Code", 'KMCIC');
                            if studentgroup.FindFirst() then
                                premed2 := 'KMCIC'
                            else
                                premed2 := '';

                            studentmaster.Reset();
                            studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                            studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                            studentmaster.SetRange("Global Dimension 1 Code", '9100');
                            if studentmaster.FindFirst() then
                                premed1 := 'AICASA'
                            else
                                premed1 := '';


                            premed := '';
                            if (premed1 <> '') and (premed2 <> '') then begin
                                premed := premed1 + ', ' + premed2;
                            end else
                                premed := premed1 + premed2;

                            // ResidencyTxt := '';
                            // if Residency."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                            //     residencyTxt := 'No';

                            // if not (Residency."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                            //     residencyTxt := 'Yes';

                            TempRecord_gRec."Unique ID" := UserId();
                            TempRecord_gRec.Field7 := graduationyear;
                            TempRecord_gRec.Field65 := premed;
                            TempRecord_gRec.Field66 := fiurotations;
                            TempRecord_gRec.Field71 := studenthonors."Honors Name";
                            TempRecord_gRec."Transcript End" := Residency."Residency Type";
                            TempRecord_gRec.Insert();

                        end Else begin
                            Residency_lRec.Reset();
                            Residency_lRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            Residency_lRec.SetRange("Residency Year", Residency."Residency Year");
                            Residency_lRec.SetRange("Residency Type", 'YES');
                            IF Residency_lRec.FindSet() then begin
                                repeat
                                    PlacementTypeCount := 0;
                                    //IF ResidentYearFilter1 <> Residency_lRec."Residency Year" then begin
                                    IF Residency_lRec."Residency Placement Type" IN ['CATEGORICAL', 'ADVANCED', 'TRANSITIONAL', 'PRELIMINARY'] then begin
                                        Residency_lRec1.Reset();
                                        Residency_lRec1.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_lRec1.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_lRec1.SetRange("Residency Placement Type", Residency_lRec."Residency Placement Type");
                                        Residency_lRec1.SetRange("Residency Type", 'YES');
                                        PlacementTypeCount := Residency_lRec1.Count();
                                    end;

                                    IF Residency_lRec."Residency Placement Type" = '' then begin
                                        Residency_lRec1.Reset();
                                        Residency_lRec1.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_lRec1.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_lRec1.SetRange("Residency Placement Type", '');
                                        Residency_lRec1.SetRange("Residency Type", 'YES');
                                        PlacementTypeCount := Residency_lRec1.Count();
                                    end;

                                    IF PlacementTypeCount = 1 then begin
                                        TempRecord_gRec.Reset();
                                        IF TempRecord_gRec.FindLast() then
                                            EntryNo := TempRecord_gRec."Entry No" + 1
                                        Else
                                            EntryNo := 1;

                                        TempRecord_gRec.Init();
                                        TempRecord_gRec."Entry No" := EntryNo;
                                        TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                        TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                        TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                        TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                        TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);


                                        country.Reset();
                                        country.SetRange(Code, "Student Master-CS".Nationality);
                                        if country.FindFirst() then
                                            TempRecord_gRec.Field14 := country.Nationality
                                        else
                                            TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                        EthnicityCode := '';
                                        studentEthnicity.Reset();
                                        studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                        if studentEthnicity.findset() then
                                            repeat
                                                if EthnicityCode = '' then
                                                    EthnicityCode := studentEthnicity."Ethnicity Name"
                                                else
                                                    EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                            until studentEthnicity.Next() = 0;

                                        TempRecord_gRec.Field51 := EthnicityCode;

                                        Evaluate(TempRecord_gRec.Program, Residency_lRec."Residency Year");
                                        TempRecord_gRec.Field38 := Residency_lRec."Residency Placement Type";
                                        TempRecord_gRec.Field39 := Residency_lRec."Residency Specialty";
                                        TempRecord_gRec.Field40 := Residency_lRec."Residency Status";
                                        IF Residency_lRec."Residency Placement Type" = 'CATEGORICAL' then
                                            TempRecord_gRec.Field33 := 1;
                                        IF Residency_lRec."Residency Placement Type" = '' then
                                            TempRecord_gRec.Field33 := 2;
                                        IF Residency_lRec."Residency Placement Type" = 'ADVANCED' then
                                            TempRecord_gRec.Field33 := 3;
                                        IF Residency_lRec."Residency Placement Type" = 'TRANSITIONAL' then
                                            TempRecord_gRec.Field33 := 4;
                                        IF Residency_lRec."Residency Placement Type" = 'PRELIMINARY' then
                                            TempRecord_gRec.Field33 := 5;

                                        TempRecord_gRec.Field44 := Residency_lRec."Hospital Name";
                                        TempRecord_gRec.Field46 := Residency_lRec."Hospital City";
                                        TempRecord_gRec.Field47 := Residency_lRec."Hospital State";

                                        IF (Strpos(Residency_lRec."Residency Placement Type", 'Prelim') > 0) Or (Strpos(Residency_lRec."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_lRec."Residency Specialty", 'Prelim') > 0) then
                                            TempRecord_gRec."Residency Preliminary" := 'Yes'
                                        else
                                            TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                        TempRecord_gRec."Licence State" := LicenseTrackingState;
                                        TempRecord_gRec."Licence Type" := LicenseType;

                                        TempRecord_gRec.Select := true;

                                        country.Reset();
                                        country.SetRange(Code, Residency_lRec."Hospital Country");
                                        if country.FindFirst() then
                                            TempRecord_gRec.Field48 := country.Name;

                                        TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                        TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                        TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                        TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                        TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                        TempRecord_gRec.Field54 := "Student Master-CS".City;

                                        staterec.Reset();
                                        staterec.SetRange(code, "Student Master-CS".State);
                                        staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                        if staterec.FindFirst() then
                                            TempRecord_gRec.Field58 := staterec.Description;

                                        TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                        country.Reset();
                                        country.SetRange(Code, "Student Master-CS"."Country Code");
                                        IF country.FindFirst() then
                                            TempRecord_gRec.Field59 := country.Name;

                                        TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                        IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                            TempRecord_gRec."Enrollment No." := 'Yes'
                                        Else
                                            TempRecord_gRec."Enrollment No." := '';


                                        // If TempRecord_gRec.Field33 = 1 then
                                        //     PlacementActualOrder += 1;
                                        // If TempRecord_gRec.Field33 <> 1 then
                                        //     PlacementActualOrder += 1;
                                        // TempRecord_gRec.Field32 := PlacementActualOrder;
                                        Clear(studenthonors);
                                        studenthonors.Reset();
                                        studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                        if studenthonors.FindFirst() then;

                                        fiurotations := '';
                                        graduationyear := '';
                                        studentdegree.Reset();
                                        studentdegree.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                        studentdegree.SetRange("Degree Code", 'DOC');
                                        if studentdegree.FindFirst() then begin
                                            graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                            rosterledgerentry.Reset();
                                            rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                            rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                            rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                            rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                            if rosterledgerentry.FindFirst() then begin
                                                if rosterledgerentry.count > 5 then
                                                    fiurotations := 'Yes'
                                                else
                                                    fiurotations := '';
                                            end;
                                        end;

                                        premed2 := '';
                                        premed1 := '';
                                        studentgroup.Reset();
                                        studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                        Studentgroup.SetRange("Groups Code", 'KMCIC');
                                        if studentgroup.FindFirst() then
                                            premed2 := 'KMCIC'
                                        else
                                            premed2 := '';

                                        studentmaster.Reset();
                                        studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                        studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                        studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                        if studentmaster.FindFirst() then
                                            premed1 := 'AICASA'
                                        else
                                            premed1 := '';


                                        premed := '';
                                        if (premed1 <> '') and (premed2 <> '') then begin
                                            premed := premed1 + ', ' + premed2;
                                        end else
                                            premed := premed1 + premed2;

                                        // ResidencyTxt := '';
                                        // if Residency_lRec."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                        //     residencyTxt := 'No';

                                        // if not (Residency_lRec."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                        //     residencyTxt := 'Yes';




                                        TempRecord_gRec."Unique ID" := UserId();
                                        TempRecord_gRec.Field7 := graduationyear;
                                        TempRecord_gRec.Field65 := premed;
                                        TempRecord_gRec.Field66 := fiurotations;
                                        TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                        TempRecord_gRec."Transcript End" := Residency_lRec."Residency Type";
                                        TempRecord_gRec.Insert();
                                    end Else begin
                                        Residency_gRec.Reset();
                                        Residency_gRec.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_gRec.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_gRec.SetRange("Residency Placement Type", '');
                                        Residency_gRec.SetRange("Residency Type", 'YES');
                                        If Residency_gRec.FindFirst() then begin
                                            repeat
                                                IF ResidentYearFilter2 <> Residency_gRec."Residency Year" then begin
                                                    SpecialityCount := 0;
                                                    Residency_gRec1.Reset();
                                                    Residency_gRec1.SetRange("Enrollment No.", Residency_gRec."Enrollment No.");
                                                    Residency_gRec1.SetRange("Residency Year", Residency_gRec."Residency Year");
                                                    Residency_gRec1.SetRange("Residency Placement Type", '');
                                                    Residency_gRec1.SetFilter("Residency Specialty", '<>%1&<>%2&<>%3&<>%4&<>%5', '*Categorical', '*Advanced', '*Transitional', '*Preliminary', '*Prelim*');
                                                    Residency_gRec1.SetRange("Residency Type", 'YES');
                                                    If Residency_gRec1.FindSet() then begin
                                                        repeat
                                                            SpecialityCount := Residency_gRec1.Count();
                                                            If SpecialityCount > 1 then begin
                                                                TempRecord_gRec.Reset();
                                                                IF TempRecord_gRec.FindLast() then
                                                                    EntryNo := TempRecord_gRec."Entry No" + 1
                                                                Else
                                                                    EntryNo := 1;

                                                                TempRecord_gRec.Init();
                                                                TempRecord_gRec."Entry No" := EntryNo;
                                                                TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                                                TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                                                TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                                                TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                                                TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);

                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS".Nationality);
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field14 := country.Nationality
                                                                else
                                                                    TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                                                EthnicityCode := '';
                                                                studentEthnicity.Reset();
                                                                studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                                                if studentEthnicity.findset() then
                                                                    repeat
                                                                        if EthnicityCode = '' then
                                                                            EthnicityCode := studentEthnicity."Ethnicity Name"
                                                                        else
                                                                            EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                                                    until studentEthnicity.Next() = 0;

                                                                TempRecord_gRec.Field51 := EthnicityCode;

                                                                Evaluate(TempRecord_gRec.Program, Residency_gRec1."Residency Year");
                                                                TempRecord_gRec.Field38 := Residency_gRec1."Residency Placement Type";
                                                                TempRecord_gRec.Field39 := Residency_gRec1."Residency Specialty";
                                                                TempRecord_gRec.Field40 := Residency_gRec1."Residency Status";

                                                                If Residency_gRec1."Residency Status" = 'MATCHED' then
                                                                    TempRecord_gRec.Field33 := 1;
                                                                If Residency_gRec1."Residency Status" = 'MATCHED - ADVANCED' then
                                                                    TempRecord_gRec.Field33 := 2;
                                                                If Residency_gRec1."Residency Status" = 'PRE-MATCHED' then
                                                                    TempRecord_gRec.Field33 := 3;
                                                                If Residency_gRec1."Residency Status" = 'PRE-MATCH' then
                                                                    TempRecord_gRec.Field33 := 4;
                                                                If Residency_gRec1."Residency Status" = 'SOAP ADVANCED' then
                                                                    TempRecord_gRec.Field33 := 5;
                                                                If Residency_gRec1."Residency Status" = 'SOAP' then
                                                                    TempRecord_gRec.Field33 := 6;
                                                                If Residency_gRec1."Residency Status" = 'SCRAMBLED\SOAP' then
                                                                    TempRecord_gRec.Field33 := 7;
                                                                If Residency_gRec1."Residency Status" = 'SCRAMBLED' then
                                                                    TempRecord_gRec.Field33 := 8;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE MATCH' then
                                                                    TempRecord_gRec.Field33 := 9;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE' then
                                                                    TempRecord_gRec.Field33 := 10;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE.' then
                                                                    TempRecord_gRec.Field33 := 11;
                                                                If Residency_gRec1."Residency Status" = 'OUTSIDE OF MATCH' then
                                                                    TempRecord_gRec.Field33 := 12;
                                                                If Residency_gRec1."Residency Status" = 'MATCHED-ADVWITHDRAWN' then
                                                                    TempRecord_gRec.Field33 := 13;
                                                                If Residency_gRec1."Residency Status" = 'NO MATCHED' then
                                                                    TempRecord_gRec.Field33 := 14;
                                                                If Residency_gRec1."Residency Status" = 'PENDING' then
                                                                    TempRecord_gRec.Field33 := 15;
                                                                If Residency_gRec1."Residency Status" = 'OPTEDOUT' then
                                                                    TempRecord_gRec.Field33 := 16;
                                                                If Residency_gRec1."Residency Status" = 'WITHDRAWAN' then
                                                                    TempRecord_gRec.Field33 := 17;
                                                                If Residency_gRec1."Residency Status" = 'INCOMPLETE' then
                                                                    TempRecord_gRec.Field33 := 18;

                                                                TempRecord_gRec.Field44 := Residency_gRec1."Hospital Name";
                                                                TempRecord_gRec.Field46 := Residency_gRec1."Hospital City";
                                                                TempRecord_gRec.Field47 := Residency_gRec1."Hospital State";

                                                                IF (Strpos(Residency_gRec1."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency_gRec1."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0) then
                                                                    TempRecord_gRec."Residency Preliminary" := 'Yes'
                                                                else
                                                                    TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                                                TempRecord_gRec."Licence State" := LicenseTrackingState;
                                                                TempRecord_gRec."Licence Type" := LicenseType;

                                                                TempRecord_gRec.Select := true;

                                                                country.Reset();
                                                                country.SetRange(Code, Residency_gRec1."Hospital Country");
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field48 := country.Name;

                                                                TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                                                TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                                                TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                                                TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                                                TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                                                TempRecord_gRec.Field54 := "Student Master-CS".City;

                                                                staterec.Reset();
                                                                staterec.SetRange(code, "Student Master-CS".State);
                                                                staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                                                if staterec.FindFirst() then
                                                                    TempRecord_gRec.Field58 := staterec.Description;

                                                                TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS"."Country Code");
                                                                IF country.FindFirst() then
                                                                    TempRecord_gRec.Field59 := country.Name;

                                                                TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                                                IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                                                    TempRecord_gRec."Enrollment No." := 'Yes'
                                                                Else
                                                                    TempRecord_gRec."Enrollment No." := '';

                                                                TempRecord_gRec."Unique ID" := UserId();

                                                                Clear(studenthonors);
                                                                studenthonors.Reset();
                                                                studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                                                if studenthonors.FindFirst() then;

                                                                fiurotations := '';
                                                                graduationyear := '';
                                                                studentdegree.Reset();
                                                                studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                                                                studentdegree.SetRange("Degree Code", 'DOC');
                                                                if studentdegree.FindFirst() then begin
                                                                    graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                                                    rosterledgerentry.Reset();
                                                                    rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                                                    rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                                                    rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                                                    rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                                                    if rosterledgerentry.FindFirst() then begin
                                                                        if rosterledgerentry.count > 5 then
                                                                            fiurotations := 'Yes'
                                                                        else
                                                                            fiurotations := '';
                                                                    end;
                                                                end;

                                                                premed2 := '';
                                                                premed1 := '';
                                                                studentgroup.Reset();
                                                                studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                                                Studentgroup.SetRange("Groups Code", 'KMCIC');
                                                                if studentgroup.FindFirst() then
                                                                    premed2 := 'KMCIC'
                                                                else
                                                                    premed2 := '';

                                                                studentmaster.Reset();
                                                                studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                                                studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                                                studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                                                if studentmaster.FindFirst() then
                                                                    premed1 := 'AICASA'
                                                                else
                                                                    premed1 := '';


                                                                premed := '';
                                                                if (premed1 <> '') and (premed2 <> '') then begin
                                                                    premed := premed1 + ', ' + premed2;
                                                                end else
                                                                    premed := premed1 + premed2;

                                                                // ResidencyTxt := '';
                                                                // if Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                                                //     residencyTxt := 'No';

                                                                // if not (Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                                                //     residencyTxt := 'Yes';

                                                                TempRecord_gRec.Field7 := graduationyear;
                                                                TempRecord_gRec.Field65 := premed;
                                                                TempRecord_gRec.Field66 := fiurotations;
                                                                TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                                                TempRecord_gRec."Transcript End" := Residency_gRec1."Residency Type";


                                                                TempRecord_gRec.Insert();
                                                            end;
                                                        until Residency_gRec1.Next() = 0;
                                                    end;
                                                    Residency_gRec1.Reset();
                                                    Residency_gRec1.SetRange("Enrollment No.", Residency_gRec."Enrollment No.");
                                                    Residency_gRec1.SetRange("Residency Year", Residency_gRec."Residency Year");
                                                    Residency_gRec1.SetRange("Residency Placement Type", Residency_gRec."Residency Placement Type");
                                                    Residency_gRec1.SetRange("Residency Type", 'YES');
                                                    //Residency_gRec1.SetRange("Residency No.", Residency_gRec."Residency No.");
                                                    If Residency_gRec1.FindSet() then begin
                                                        repeat
                                                            SpecialityCount := 0;
                                                            SpecialityCount1 := 0;
                                                            SpecialityCount2 := 0;
                                                            SpecialityCount3 := 0;
                                                            SpecialityCount4 := 0;
                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Categorical');
                                                            Residency_gRec2.SetRange("Residency Type", 'YES');
                                                            SpecialityCount := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '');
                                                            Residency_gRec2.SetRange("Residency Type", 'YES');
                                                            SpecialityCount1 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Advanced');
                                                            Residency_gRec2.SetRange("Residency Type", 'YES');
                                                            SpecialityCount2 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Transitional');
                                                            Residency_gRec2.SetRange("Residency Type", 'YES');
                                                            SpecialityCount3 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1|%2', '*Preliminary', '*Prelim*');
                                                            Residency_gRec2.SetRange("Residency Type", 'YES');
                                                            SpecialityCount4 := Residency_gREc2.Count();

                                                            IF (SpecialityCount = 1) or (SpecialityCount1 = 1) or (SpecialityCount2 = 1) or (SpecialityCount3 = 1) or (SpecialityCount4 = 1) then begin
                                                                TempRecord_gRec.Reset();
                                                                IF TempRecord_gRec.FindLast() then
                                                                    EntryNo := TempRecord_gRec."Entry No" + 1
                                                                Else
                                                                    EntryNo := 1;

                                                                TempRecord_gRec.Init();
                                                                TempRecord_gRec."Entry No" := EntryNo;
                                                                TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                                                TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                                                TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                                                TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                                                TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);


                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS".Nationality);
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field14 := country.Nationality
                                                                else
                                                                    TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                                                EthnicityCode := '';
                                                                studentEthnicity.Reset();
                                                                studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                                                if studentEthnicity.findset() then
                                                                    repeat
                                                                        if EthnicityCode = '' then
                                                                            EthnicityCode := studentEthnicity."Ethnicity Name"
                                                                        else
                                                                            EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                                                    until studentEthnicity.Next() = 0;

                                                                TempRecord_gRec.Field51 := EthnicityCode;

                                                                Evaluate(TempRecord_gRec.Program, Residency_gRec1."Residency Year");
                                                                TempRecord_gRec.Field38 := Residency_gRec1."Residency Placement Type";
                                                                TempRecord_gRec.Field39 := Residency_gRec1."Residency Specialty";
                                                                TempRecord_gRec.Field40 := Residency_gRec1."Residency Status";
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Categorical') > 0 then
                                                                    TempRecord_gRec.Field33 := 1;

                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Advanced') > 0 then
                                                                    TempRecord_gRec.Field33 := 3;
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Transitional') > 0 then
                                                                    TempRecord_gRec.Field33 := 4;
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Preliminary') > 0 then
                                                                    TempRecord_gRec.Field33 := 5;

                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0 then
                                                                    TempRecord_gRec.Field33 := 5;

                                                                If TempRecord_gRec.Field33 = 0 then
                                                                    TempRecord_gRec.Field33 := 2;


                                                                TempRecord_gRec.Field44 := Residency_gRec1."Hospital Name";
                                                                TempRecord_gRec.Field46 := Residency_gRec1."Hospital City";
                                                                TempRecord_gRec.Field47 := Residency_gRec1."Hospital State";

                                                                IF (Strpos(Residency_gRec1."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency_gRec1."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0) then
                                                                    TempRecord_gRec."Residency Preliminary" := 'Yes'
                                                                else
                                                                    TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                                                TempRecord_gRec."Licence State" := LicenseTrackingState;
                                                                TempRecord_gRec."Licence Type" := LicenseType;

                                                                TempRecord_gRec.Select := true;

                                                                country.Reset();
                                                                country.SetRange(Code, Residency_gRec1."Hospital Country");
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field48 := country.Name;

                                                                TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                                                TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                                                TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                                                TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                                                TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                                                TempRecord_gRec.Field54 := "Student Master-CS".City;

                                                                staterec.Reset();
                                                                staterec.SetRange(code, "Student Master-CS".State);
                                                                staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                                                if staterec.FindFirst() then
                                                                    TempRecord_gRec.Field58 := staterec.Description;

                                                                TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS"."Country Code");
                                                                IF country.FindFirst() then
                                                                    TempRecord_gRec.Field59 := country.Name;

                                                                TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                                                IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                                                    TempRecord_gRec."Enrollment No." := 'Yes'
                                                                Else
                                                                    TempRecord_gRec."Enrollment No." := '';

                                                                TempRecord_gRec."Unique ID" := UserId();

                                                                Clear(studenthonors);
                                                                studenthonors.Reset();
                                                                studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                                                if studenthonors.FindFirst() then;

                                                                fiurotations := '';
                                                                graduationyear := '';
                                                                studentdegree.Reset();
                                                                studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                                                                studentdegree.SetRange("Degree Code", 'DOC');
                                                                if studentdegree.FindFirst() then begin
                                                                    graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                                                    rosterledgerentry.Reset();
                                                                    rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                                                    rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                                                    rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                                                    rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                                                    if rosterledgerentry.FindFirst() then begin
                                                                        if rosterledgerentry.count > 5 then
                                                                            fiurotations := 'Yes'
                                                                        else
                                                                            fiurotations := '';
                                                                    end;
                                                                end;

                                                                premed2 := '';
                                                                premed1 := '';
                                                                studentgroup.Reset();
                                                                studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                                                Studentgroup.SetRange("Groups Code", 'KMCIC');
                                                                if studentgroup.FindFirst() then
                                                                    premed2 := 'KMCIC'
                                                                else
                                                                    premed2 := '';

                                                                studentmaster.Reset();
                                                                studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                                                studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                                                studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                                                if studentmaster.FindFirst() then
                                                                    premed1 := 'AICASA'
                                                                else
                                                                    premed1 := '';


                                                                premed := '';
                                                                if (premed1 <> '') and (premed2 <> '') then begin
                                                                    premed := premed1 + ', ' + premed2;
                                                                end else
                                                                    premed := premed1 + premed2;

                                                                // ResidencyTxt := '';
                                                                // if Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                                                //     residencyTxt := 'No';

                                                                // if not (Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                                                //     residencyTxt := 'Yes';


                                                                TempRecord_gRec.Field7 := graduationyear;
                                                                TempRecord_gRec.Field65 := premed;
                                                                TempRecord_gRec.Field66 := fiurotations;
                                                                TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                                                TempRecord_gRec."Transcript End" := Residency_gRec1."Residency Type";

                                                                TempRecord_gRec.Insert();
                                                            end;

                                                        until Residency_gRec1.Next() = 0;
                                                    end;
                                                    ResidentYearFilter2 := Residency_gRec."Residency Year";
                                                end;

                                            until Residency_gRec.Next() = 0;
                                        end;


                                    end;
                                //     ResidentYearFilter1 := Residency_lRec."Residency Year";
                                // End;
                                until Residency_lRec.Next() = 0;
                            end;
                        end;
                        ResidentYearFilter := Residency."Residency Year";
                    End;

                end;

                trigger OnPostDataItem()
                begin
                    TempRecord_gRec.Reset();
                    TempRecord_gRec.SetCurrentKey(Program);
                    TempRecord_gRec.Ascending(false);
                    TempRecord_gRec.SetRange(Select, true);
                    TempRecord_gRec.SetRange("Transcript End", 'YES');
                    IF TempRecord_gRec.FindSet() then begin
                        repeat
                            TempRecord_gRec1.Reset();
                            TempRecord_gRec1.SetCurrentKey(Field33);
                            TempRecord_gRec1.SetRange(Program, TempRecord_gRec.Program);
                            TempRecord_gRec1.SetRange(Select, true);
                            TempRecord_gRec.SetRange("Transcript End", 'YES');
                            IF TempRecord_gRec1.FindSet() then begin
                                repeat
                                    IF TempRecord_gRec1.Field33 = 1 then
                                        PlacementActualOrder += 1;
                                    IF TempRecord_gRec1.Field33 <> 1 then
                                        PlacementActualOrder += 1;
                                    TempRecord_gRec1.Field32 := PlacementActualOrder;
                                    TempRecord_gRec1.Select := false;

                                    TempRecord_gRec1.Modify();
                                until TempRecord_gRec1.Next() = 0;
                            end;
                        until TempRecord_gRec.Next() = 0;

                    end;
                end;

            }

            dataitem(Residency1; Residency)
            {
                DataItemLink = "Enrollment No." = field("Enrollment No.");
                DataItemTableView = where("Residency Type" = filter('NO'));
                trigger OnPreDataItem()
                begin
                    Residency1.SetCurrentKey("Residency Year");
                    Residency1.Ascending(false);
                    PlacementActualOrder := 0;
                    PlacementFieldOrder := 0;
                    ResidentYearFilter3 := '';
                    ResidentYearFilter4 := '';
                    ResidentYearFilter5 := '';
                end;

                trigger OnAfterGetRecord()
                var

                    YearCount: Integer;
                    EthnicityCode: Text;
                    PlacementTypeCount: Integer;
                    EntryNo: Integer;
                    globalhealthtrack: Text;
                    fiurotations: text;
                    residencyTxt: text;
                    premed: Text;
                    premed1: Text;
                    premed2: Text;
                    ResidencySpecialty: Text;
                    hospitalname: Text;
                    hospitalcity: Code[20];
                    hospitalstate: Code[20];
                    hospitalcountry: Text;
                    studentstatus: Code[20];
                    studentcountry: Text;
                    residencystatus: text;
                    graduationyear: Text;
                    residencyorder: Integer;
                    residencyorder2: Integer;
                    residencyorderlast: Text;
                    nationalityname: Text;
                    residencystate: Text;
                    statedesc: text;
                    placementtype: text;
                    StringPOs: Integer;

                begin
                    If ResidentYearFilter3 <> Residency1."Residency Year" then begin
                        YearCount := 0;
                        Residency_lRec.Reset();
                        Residency_lRec.SetRange("Enrollment No.", Residency1."Enrollment No.");
                        Residency_lRec.SetRange("Residency Year", Residency1."Residency Year");
                        Residency_lRec.SetRange("Residency Type", 'NO');
                        YearCount := Residency_lRec.Count();

                        IF YearCount = 1 then begin
                            TempRecord_gRec.Reset();
                            IF TempRecord_gRec.FindLast() then
                                EntryNo := TempRecord_gRec."Entry No" + 1
                            Else
                                EntryNo := 1;

                            TempRecord_gRec.Init();
                            TempRecord_gRec."Entry No" := EntryNo;
                            TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                            TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                            TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                            TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                            TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);


                            country.Reset();
                            country.SetRange(Code, "Student Master-CS".Nationality);
                            if country.FindFirst() then
                                TempRecord_gRec.Field14 := country.Nationality
                            else
                                TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                            EthnicityCode := '';
                            studentEthnicity.Reset();
                            studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                            if studentEthnicity.findset() then
                                repeat
                                    if EthnicityCode = '' then
                                        EthnicityCode := studentEthnicity."Ethnicity Name"
                                    else
                                        EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                until studentEthnicity.Next() = 0;

                            TempRecord_gRec.Field51 := EthnicityCode;

                            Evaluate(TempRecord_gRec.Program, Residency1."Residency Year");
                            TempRecord_gRec.Field38 := Residency1."Residency Placement Type";
                            TempRecord_gRec.Field39 := Residency1."Residency Specialty";
                            TempRecord_gRec.Field40 := Residency1."Residency Status";

                            PlacementActualOrder += 1;
                            TempRecord_gRec.Field32 := PlacementActualOrder;

                            TempRecord_gRec.Field44 := Residency1."Hospital Name";
                            TempRecord_gRec.Field46 := Residency1."Hospital City";
                            TempRecord_gRec.Field47 := Residency1."Hospital State";

                            IF (Strpos(Residency1."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency1."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency1."Residency Specialty", 'Prelim') > 0) then
                                TempRecord_gRec."Residency Preliminary" := 'Yes'
                            else
                                TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                            TempRecord_gRec."Licence State" := LicenseTrackingState;
                            TempRecord_gRec."Licence Type" := LicenseType;

                            country.Reset();
                            country.SetRange(Code, Residency1."Hospital Country");
                            if country.FindFirst() then
                                TempRecord_gRec.Field48 := country.Name;

                            TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                            TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                            TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                            TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                            TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                            TempRecord_gRec.Field54 := "Student Master-CS".City;

                            staterec.Reset();
                            staterec.SetRange(code, "Student Master-CS".State);
                            staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                            if staterec.FindFirst() then
                                TempRecord_gRec.Field58 := staterec.Description;

                            TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                            country.Reset();
                            country.SetRange(Code, "Student Master-CS"."Country Code");
                            IF country.FindFirst() then
                                TempRecord_gRec.Field59 := country.Name;

                            TempRecord_gRec.Field60 := "Student Master-CS".Status;
                            IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                TempRecord_gRec."Enrollment No." := 'Yes'
                            Else
                                TempRecord_gRec."Enrollment No." := '';

                            Clear(studenthonors);
                            studenthonors.Reset();
                            studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            if studenthonors.FindFirst() then;

                            fiurotations := '';
                            graduationyear := '';
                            studentdegree.Reset();
                            studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                            studentdegree.SetRange("Degree Code", 'DOC');
                            if studentdegree.FindFirst() then begin
                                graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                rosterledgerentry.Reset();
                                rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                if rosterledgerentry.FindFirst() then begin
                                    if rosterledgerentry.count > 5 then
                                        fiurotations := 'Yes'
                                    else
                                        fiurotations := '';
                                end;
                            end;

                            premed2 := '';
                            premed1 := '';
                            studentgroup.Reset();
                            studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                            Studentgroup.SetRange("Groups Code", 'KMCIC');
                            if studentgroup.FindFirst() then
                                premed2 := 'KMCIC'
                            else
                                premed2 := '';

                            studentmaster.Reset();
                            studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                            studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                            studentmaster.SetRange("Global Dimension 1 Code", '9100');
                            if studentmaster.FindFirst() then
                                premed1 := 'AICASA'
                            else
                                premed1 := '';


                            premed := '';
                            if (premed1 <> '') and (premed2 <> '') then begin
                                premed := premed1 + ', ' + premed2;
                            end else
                                premed := premed1 + premed2;

                            // ResidencyTxt := '';
                            // if Residency1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                            //     residencyTxt := 'No';

                            // if not (Residency1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                            //     residencyTxt := 'Yes';

                            TempRecord_gRec."Unique ID" := UserId();
                            TempRecord_gRec.Field7 := graduationyear;
                            TempRecord_gRec.Field65 := premed;
                            TempRecord_gRec.Field66 := fiurotations;
                            TempRecord_gRec.Field71 := studenthonors."Honors Name";
                            TempRecord_gRec."Transcript End" := Residency1."Residency Type";
                            TempRecord_gRec.Insert();

                        end Else begin
                            Residency_lRec.Reset();
                            Residency_lRec.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                            Residency_lRec.SetRange("Residency Year", Residency1."Residency Year");
                            Residency_lRec.SetRange("Residency Type", 'NO');
                            IF Residency_lRec.FindSet() then begin
                                repeat
                                    PlacementTypeCount := 0;
                                    // IF ResidentYearFilter4 <> Residency_lRec."Residency Year" then begin
                                    IF Residency_lRec."Residency Placement Type" IN ['CATEGORICAL', 'ADVANCED', 'TRANSITIONAL', 'PRELIMINARY'] then begin
                                        Residency_lRec1.Reset();
                                        Residency_lRec1.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_lRec1.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_lRec1.SetRange("Residency Placement Type", Residency_lRec."Residency Placement Type");
                                        Residency_lRec1.SetRange("Residency Type", 'NO');
                                        PlacementTypeCount := Residency_lRec1.Count();
                                    end;

                                    IF Residency_lRec."Residency Placement Type" = '' then begin
                                        Residency_lRec1.Reset();
                                        Residency_lRec1.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_lRec1.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_lRec1.SetRange("Residency Placement Type", '');
                                        Residency_lRec1.SetRange("Residency Type", 'NO');
                                        PlacementTypeCount := Residency_lRec1.Count();
                                    end;

                                    IF PlacementTypeCount = 1 then begin
                                        TempRecord_gRec.Reset();
                                        IF TempRecord_gRec.FindLast() then
                                            EntryNo := TempRecord_gRec."Entry No" + 1
                                        Else
                                            EntryNo := 1;

                                        TempRecord_gRec.Init();
                                        TempRecord_gRec."Entry No" := EntryNo;
                                        TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                        TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                        TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                        TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                        TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);

                                        country.Reset();
                                        country.SetRange(Code, "Student Master-CS".Nationality);
                                        if country.FindFirst() then
                                            TempRecord_gRec.Field14 := country.Nationality
                                        else
                                            TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                        EthnicityCode := '';
                                        studentEthnicity.Reset();
                                        studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                        if studentEthnicity.findset() then
                                            repeat
                                                if EthnicityCode = '' then
                                                    EthnicityCode := studentEthnicity."Ethnicity Name"
                                                else
                                                    EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                            until studentEthnicity.Next() = 0;

                                        TempRecord_gRec.Field51 := EthnicityCode;

                                        Evaluate(TempRecord_gRec.Program, Residency_lRec."Residency Year");
                                        TempRecord_gRec.Field38 := Residency_lRec."Residency Placement Type";
                                        TempRecord_gRec.Field39 := Residency_lRec."Residency Specialty";
                                        TempRecord_gRec.Field40 := Residency_lRec."Residency Status";
                                        IF Residency_lRec."Residency Placement Type" = 'CATEGORICAL' then
                                            TempRecord_gRec.Field33 := 1;
                                        IF Residency_lRec."Residency Placement Type" = '' then
                                            TempRecord_gRec.Field33 := 2;
                                        IF Residency_lRec."Residency Placement Type" = 'ADVANCED' then
                                            TempRecord_gRec.Field33 := 3;
                                        IF Residency_lRec."Residency Placement Type" = 'TRANSITIONAL' then
                                            TempRecord_gRec.Field33 := 4;
                                        IF Residency_lRec."Residency Placement Type" = 'PRELIMINARY' then
                                            TempRecord_gRec.Field33 := 5;

                                        TempRecord_gRec.Field44 := Residency_lRec."Hospital Name";
                                        TempRecord_gRec.Field46 := Residency_lRec."Hospital City";
                                        TempRecord_gRec.Field47 := Residency_lRec."Hospital State";

                                        IF (Strpos(Residency_lRec."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency_lRec."Residency Placement Type", 'PRELIM') > 0) or (Strpos(Residency_lRec."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_lRec."Residency Specialty", 'Prelim') > 0) then
                                            TempRecord_gRec."Residency Preliminary" := 'Yes'
                                        else
                                            TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                        TempRecord_gRec."Licence State" := LicenseTrackingState;
                                        TempRecord_gRec."Licence Type" := LicenseType;

                                        TempRecord_gRec.Select := true;

                                        country.Reset();
                                        country.SetRange(Code, Residency_lRec."Hospital Country");
                                        if country.FindFirst() then
                                            TempRecord_gRec.Field48 := country.Name;

                                        TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                        TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                        TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                        TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                        TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                        TempRecord_gRec.Field54 := "Student Master-CS".City;

                                        staterec.Reset();
                                        staterec.SetRange(code, "Student Master-CS".State);
                                        staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                        if staterec.FindFirst() then
                                            TempRecord_gRec.Field58 := staterec.Description;

                                        TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                        country.Reset();
                                        country.SetRange(Code, "Student Master-CS"."Country Code");
                                        IF country.FindFirst() then
                                            TempRecord_gRec.Field59 := country.Name;

                                        TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                        IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                            TempRecord_gRec."Enrollment No." := 'Yes'
                                        Else
                                            TempRecord_gRec."Enrollment No." := '';


                                        // If TempRecord_gRec.Field33 = 1 then
                                        //     PlacementActualOrder += 1;
                                        // If TempRecord_gRec.Field33 <> 1 then
                                        //     PlacementActualOrder += 1;
                                        // TempRecord_gRec.Field32 := PlacementActualOrder;
                                        Clear(studenthonors);
                                        studenthonors.Reset();
                                        studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                        if studenthonors.FindFirst() then;

                                        fiurotations := '';
                                        graduationyear := '';
                                        studentdegree.Reset();
                                        studentdegree.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                        studentdegree.SetRange("Degree Code", 'DOC');
                                        if studentdegree.FindFirst() then begin
                                            graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                            rosterledgerentry.Reset();
                                            rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                            rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                            rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                            rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                            if rosterledgerentry.FindFirst() then begin
                                                if rosterledgerentry.count > 5 then
                                                    fiurotations := 'Yes'
                                                else
                                                    fiurotations := '';
                                            end;
                                        end;

                                        premed2 := '';
                                        premed1 := '';
                                        studentgroup.Reset();
                                        studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                        Studentgroup.SetRange("Groups Code", 'KMCIC');
                                        if studentgroup.FindFirst() then
                                            premed2 := 'KMCIC'
                                        else
                                            premed2 := '';

                                        studentmaster.Reset();
                                        studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                        studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                        studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                        if studentmaster.FindFirst() then
                                            premed1 := 'AICASA'
                                        else
                                            premed1 := '';


                                        premed := '';
                                        if (premed1 <> '') and (premed2 <> '') then begin
                                            premed := premed1 + ', ' + premed2;
                                        end else
                                            premed := premed1 + premed2;

                                        // ResidencyTxt := '';
                                        // if Residency_lRec."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                        //     residencyTxt := 'No';

                                        // if not (Residency_lRec."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                        //     residencyTxt := 'Yes';




                                        TempRecord_gRec."Unique ID" := UserId();
                                        TempRecord_gRec.Field7 := graduationyear;
                                        TempRecord_gRec.Field65 := premed;
                                        TempRecord_gRec.Field66 := fiurotations;
                                        TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                        TempRecord_gRec."Transcript End" := Residency_lRec."Residency Type";
                                        TempRecord_gRec.Insert();
                                    end Else begin
                                        Residency_gRec.Reset();
                                        Residency_gRec.SetRange("Enrollment No.", Residency_lRec."Enrollment No.");
                                        Residency_gRec.SetRange("Residency Year", Residency_lRec."Residency Year");
                                        Residency_gRec.SetRange("Residency Placement Type", '');
                                        Residency_gRec.SetRange("Residency Type", 'NO');
                                        If Residency_gRec.FindFirst() then begin
                                            repeat
                                                IF ResidentYearFilter5 <> Residency_gRec."Residency Year" then begin
                                                    SpecialityCount := 0;
                                                    Residency_gRec1.Reset();
                                                    Residency_gRec1.SetRange("Enrollment No.", Residency_gRec."Enrollment No.");
                                                    Residency_gRec1.SetRange("Residency Year", Residency_gRec."Residency Year");
                                                    Residency_gRec1.SetRange("Residency Placement Type", '');
                                                    Residency_gRec1.SetFilter("Residency Specialty", '<>%1&<>%2&<>%3&<>%4&<>%5', '*Categorical', '*Advanced', '*Transitional', '*Preliminary', '*Prelim*');
                                                    Residency_gRec1.SetRange("Residency Type", 'NO');
                                                    If Residency_gRec1.FindSet() then begin
                                                        repeat
                                                            SpecialityCount := Residency_gRec1.Count();
                                                            If SpecialityCount > 1 then begin
                                                                TempRecord_gRec.Reset();
                                                                IF TempRecord_gRec.FindLast() then
                                                                    EntryNo := TempRecord_gRec."Entry No" + 1
                                                                Else
                                                                    EntryNo := 1;

                                                                TempRecord_gRec.Init();
                                                                TempRecord_gRec."Entry No" := EntryNo;
                                                                TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                                                TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                                                TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                                                TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                                                TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);

                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS".Nationality);
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field14 := country.Nationality
                                                                else
                                                                    TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                                                EthnicityCode := '';
                                                                studentEthnicity.Reset();
                                                                studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                                                if studentEthnicity.findset() then
                                                                    repeat
                                                                        if EthnicityCode = '' then
                                                                            EthnicityCode := studentEthnicity."Ethnicity Name"
                                                                        else
                                                                            EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                                                    until studentEthnicity.Next() = 0;

                                                                TempRecord_gRec.Field51 := EthnicityCode;

                                                                Evaluate(TempRecord_gRec.Program, Residency_gRec1."Residency Year");
                                                                TempRecord_gRec.Field38 := Residency_gRec1."Residency Placement Type";
                                                                TempRecord_gRec.Field39 := Residency_gRec1."Residency Specialty";
                                                                TempRecord_gRec.Field40 := Residency_gRec1."Residency Status";

                                                                If Residency_gRec1."Residency Status" = 'MATCHED' then
                                                                    TempRecord_gRec.Field33 := 1;
                                                                If Residency_gRec1."Residency Status" = 'MATCHED - ADVANCED' then
                                                                    TempRecord_gRec.Field33 := 2;
                                                                If Residency_gRec1."Residency Status" = 'PRE-MATCHED' then
                                                                    TempRecord_gRec.Field33 := 3;
                                                                If Residency_gRec1."Residency Status" = 'PRE-MATCH' then
                                                                    TempRecord_gRec.Field33 := 4;
                                                                If Residency_gRec1."Residency Status" = 'SOAP ADVANCED' then
                                                                    TempRecord_gRec.Field33 := 5;
                                                                If Residency_gRec1."Residency Status" = 'SOAP' then
                                                                    TempRecord_gRec.Field33 := 6;
                                                                If Residency_gRec1."Residency Status" = 'SCRAMBLED\SOAP' then
                                                                    TempRecord_gRec.Field33 := 7;
                                                                If Residency_gRec1."Residency Status" = 'SCRAMBLED' then
                                                                    TempRecord_gRec.Field33 := 8;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE MATCH' then
                                                                    TempRecord_gRec.Field33 := 9;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE' then
                                                                    TempRecord_gRec.Field33 := 10;
                                                                If Residency_gRec1."Residency Status" = 'OFF-CYCLE.' then
                                                                    TempRecord_gRec.Field33 := 11;
                                                                If Residency_gRec1."Residency Status" = 'OUTSIDE OF MATCH' then
                                                                    TempRecord_gRec.Field33 := 12;
                                                                If Residency_gRec1."Residency Status" = 'MATCHED-ADVWITHDRAWN' then
                                                                    TempRecord_gRec.Field33 := 13;
                                                                If Residency_gRec1."Residency Status" = 'NO MATCHED' then
                                                                    TempRecord_gRec.Field33 := 14;
                                                                If Residency_gRec1."Residency Status" = 'PENDING' then
                                                                    TempRecord_gRec.Field33 := 15;
                                                                If Residency_gRec1."Residency Status" = 'OPTEDOUT' then
                                                                    TempRecord_gRec.Field33 := 16;
                                                                If Residency_gRec1."Residency Status" = 'WITHDRAWAN' then
                                                                    TempRecord_gRec.Field33 := 17;
                                                                If Residency_gRec1."Residency Status" = 'INCOMPLETE' then
                                                                    TempRecord_gRec.Field33 := 18;

                                                                TempRecord_gRec.Field44 := Residency_gRec1."Hospital Name";
                                                                TempRecord_gRec.Field46 := Residency_gRec1."Hospital City";
                                                                TempRecord_gRec.Field47 := Residency_gRec1."Hospital State";

                                                                IF (Strpos(Residency_gRec1."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency_gRec1."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0) then
                                                                    TempRecord_gRec."Residency Preliminary" := 'Yes'
                                                                else
                                                                    TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                                                TempRecord_gRec."Licence State" := LicenseTrackingState;
                                                                TempRecord_gRec."Licence Type" := LicenseType;

                                                                TempRecord_gRec.Select := true;

                                                                country.Reset();
                                                                country.SetRange(Code, Residency_gRec1."Hospital Country");
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field48 := country.Name;

                                                                TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                                                TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                                                TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                                                TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                                                TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                                                TempRecord_gRec.Field54 := "Student Master-CS".City;

                                                                staterec.Reset();
                                                                staterec.SetRange(code, "Student Master-CS".State);
                                                                staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                                                if staterec.FindFirst() then
                                                                    TempRecord_gRec.Field58 := staterec.Description;

                                                                TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS"."Country Code");
                                                                IF country.FindFirst() then
                                                                    TempRecord_gRec.Field59 := country.Name;

                                                                TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                                                IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                                                    TempRecord_gRec."Enrollment No." := 'Yes'
                                                                Else
                                                                    TempRecord_gRec."Enrollment No." := '';

                                                                TempRecord_gRec."Unique ID" := UserId();

                                                                Clear(studenthonors);
                                                                studenthonors.Reset();
                                                                studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                                                if studenthonors.FindFirst() then;

                                                                fiurotations := '';
                                                                graduationyear := '';
                                                                studentdegree.Reset();
                                                                studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                                                                studentdegree.SetRange("Degree Code", 'DOC');
                                                                if studentdegree.FindFirst() then begin
                                                                    graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                                                    rosterledgerentry.Reset();
                                                                    rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                                                    rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                                                    rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                                                    rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                                                    if rosterledgerentry.FindFirst() then begin
                                                                        if rosterledgerentry.count > 5 then
                                                                            fiurotations := 'Yes'
                                                                        else
                                                                            fiurotations := '';
                                                                    end;
                                                                end;

                                                                premed2 := '';
                                                                premed1 := '';
                                                                studentgroup.Reset();
                                                                studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                                                Studentgroup.SetRange("Groups Code", 'KMCIC');
                                                                if studentgroup.FindFirst() then
                                                                    premed2 := 'KMCIC'
                                                                else
                                                                    premed2 := '';

                                                                studentmaster.Reset();
                                                                studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                                                studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                                                studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                                                if studentmaster.FindFirst() then
                                                                    premed1 := 'AICASA'
                                                                else
                                                                    premed1 := '';


                                                                premed := '';
                                                                if (premed1 <> '') and (premed2 <> '') then begin
                                                                    premed := premed1 + ', ' + premed2;
                                                                end else
                                                                    premed := premed1 + premed2;

                                                                // ResidencyTxt := '';
                                                                // if Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                                                //     residencyTxt := 'No';

                                                                // if not (Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                                                //     residencyTxt := 'Yes';

                                                                TempRecord_gRec.Field7 := graduationyear;
                                                                TempRecord_gRec.Field65 := premed;
                                                                TempRecord_gRec.Field66 := fiurotations;
                                                                TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                                                TempRecord_gRec."Transcript End" := Residency_gRec1."Residency Type";


                                                                TempRecord_gRec.Insert();
                                                            end;
                                                        until Residency_gRec1.Next() = 0;
                                                    end;
                                                    Residency_gRec1.Reset();
                                                    Residency_gRec1.SetRange("Enrollment No.", Residency_gRec."Enrollment No.");
                                                    Residency_gRec1.SetRange("Residency Year", Residency_gRec."Residency Year");
                                                    Residency_gRec1.SetRange("Residency Placement Type", Residency_gRec."Residency Placement Type");
                                                    Residency_gRec1.SetRange("Residency Type", 'NO');
                                                    //Residency_gRec1.SetRange("Residency No.", Residency_gRec."Residency No.");
                                                    If Residency_gRec1.FindSet() then begin
                                                        repeat
                                                            SpecialityCount := 0;
                                                            SpecialityCount1 := 0;
                                                            SpecialityCount2 := 0;
                                                            SpecialityCount3 := 0;
                                                            SpecialityCount4 := 0;
                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Categorical');
                                                            Residency_gRec2.SetRange("Residency Type", 'NO');
                                                            SpecialityCount := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '');
                                                            Residency_gRec2.SetRange("Residency Type", 'NO');
                                                            SpecialityCount1 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Advanced');
                                                            Residency_gRec2.SetRange("Residency Type", 'NO');
                                                            SpecialityCount2 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1', '*Transitional');
                                                            Residency_gRec2.SetRange("Residency Type", 'NO');
                                                            SpecialityCount3 := Residency_gREc2.Count();

                                                            Residency_gREc2.Reset();
                                                            Residency_gREc2.SetRange("Enrollment No.", Residency_gRec1."Enrollment No.");
                                                            Residency_gREc2.SetRange("Residency Year", Residency_gRec1."Residency Year");
                                                            Residency_gREc2.SetRange("Residency Placement Type", '');
                                                            Residency_gREc2.SetFilter("Residency Specialty", '%1|%2', '*Preliminary', '*Prelim*');
                                                            Residency_gRec2.SetRange("Residency Type", 'NO');
                                                            SpecialityCount4 := Residency_gREc2.Count();

                                                            IF (SpecialityCount = 1) or (SpecialityCount1 = 1) or (SpecialityCount2 = 1) or (SpecialityCount3 = 1) or (SpecialityCount4 = 1) then begin
                                                                TempRecord_gRec.Reset();
                                                                IF TempRecord_gRec.FindLast() then
                                                                    EntryNo := TempRecord_gRec."Entry No" + 1
                                                                Else
                                                                    EntryNo := 1;

                                                                TempRecord_gRec.Init();
                                                                TempRecord_gRec."Entry No" := EntryNo;
                                                                TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                                                                TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                                                                TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                                                                TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                                                                TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);


                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS".Nationality);
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field14 := country.Nationality
                                                                else
                                                                    TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                                                                EthnicityCode := '';
                                                                studentEthnicity.Reset();
                                                                studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                                                                if studentEthnicity.findset() then
                                                                    repeat
                                                                        if EthnicityCode = '' then
                                                                            EthnicityCode := studentEthnicity."Ethnicity Name"
                                                                        else
                                                                            EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                                                                    until studentEthnicity.Next() = 0;

                                                                TempRecord_gRec.Field51 := EthnicityCode;

                                                                Evaluate(TempRecord_gRec.Program, Residency_gRec1."Residency Year");
                                                                TempRecord_gRec.Field38 := Residency_gRec1."Residency Placement Type";
                                                                TempRecord_gRec.Field39 := Residency_gRec1."Residency Specialty";
                                                                TempRecord_gRec.Field40 := Residency_gRec1."Residency Status";
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Categorical') > 0 then
                                                                    TempRecord_gRec.Field33 := 1;

                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Advanced') > 0 then
                                                                    TempRecord_gRec.Field33 := 3;
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Transitional') > 0 then
                                                                    TempRecord_gRec.Field33 := 4;
                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Preliminary') > 0 then
                                                                    TempRecord_gRec.Field33 := 5;

                                                                IF StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0 then
                                                                    TempRecord_gRec.Field33 := 5;

                                                                If TempRecord_gRec.Field33 = 0 then
                                                                    TempRecord_gRec.Field33 := 2;


                                                                TempRecord_gRec.Field44 := Residency_gRec1."Hospital Name";
                                                                TempRecord_gRec.Field46 := Residency_gRec1."Hospital City";
                                                                TempRecord_gRec.Field47 := Residency_gRec1."Hospital State";

                                                                IF (Strpos(Residency_gRec1."Residency Placement Type", 'Prelim') > 0) or (Strpos(Residency_gRec1."Residency Placement Type", 'PRELIM') > 0) or (StrPos(Residency_gRec1."Residency Specialty", 'Prelim') > 0) then
                                                                    TempRecord_gRec."Residency Preliminary" := 'Yes'
                                                                else
                                                                    TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                                                                TempRecord_gRec."Licence State" := LicenseTrackingState;
                                                                TempRecord_gRec."Licence Type" := LicenseType;

                                                                TempRecord_gRec.Select := true;

                                                                country.Reset();
                                                                country.SetRange(Code, Residency_gRec1."Hospital Country");
                                                                if country.FindFirst() then
                                                                    TempRecord_gRec.Field48 := country.Name;

                                                                TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                                                                TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                                                                TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                                                                TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                                                                TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                                                                TempRecord_gRec.Field54 := "Student Master-CS".City;

                                                                staterec.Reset();
                                                                staterec.SetRange(code, "Student Master-CS".State);
                                                                staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                                                                if staterec.FindFirst() then
                                                                    TempRecord_gRec.Field58 := staterec.Description;

                                                                TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                                                                country.Reset();
                                                                country.SetRange(Code, "Student Master-CS"."Country Code");
                                                                IF country.FindFirst() then
                                                                    TempRecord_gRec.Field59 := country.Name;

                                                                TempRecord_gRec.Field60 := "Student Master-CS".Status;
                                                                IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                                                                    TempRecord_gRec."Enrollment No." := 'Yes'
                                                                Else
                                                                    TempRecord_gRec."Enrollment No." := '';

                                                                TempRecord_gRec."Unique ID" := UserId();

                                                                Clear(studenthonors);
                                                                studenthonors.Reset();
                                                                studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                                                                if studenthonors.FindFirst() then;

                                                                fiurotations := '';
                                                                graduationyear := '';
                                                                studentdegree.Reset();
                                                                studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                                                                studentdegree.SetRange("Degree Code", 'DOC');
                                                                if studentdegree.FindFirst() then begin
                                                                    graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                                                                    rosterledgerentry.Reset();
                                                                    rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                                                                    rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                                                                    rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                                                                    rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                                                                    if rosterledgerentry.FindFirst() then begin
                                                                        if rosterledgerentry.count > 5 then
                                                                            fiurotations := 'Yes'
                                                                        else
                                                                            fiurotations := '';
                                                                    end;
                                                                end;

                                                                premed2 := '';
                                                                premed1 := '';
                                                                studentgroup.Reset();
                                                                studentgroup.SetRange("Enrollment No.", "Enrollment No.");
                                                                Studentgroup.SetRange("Groups Code", 'KMCIC');
                                                                if studentgroup.FindFirst() then
                                                                    premed2 := 'KMCIC'
                                                                else
                                                                    premed2 := '';

                                                                studentmaster.Reset();
                                                                studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                                                                studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                                                                studentmaster.SetRange("Global Dimension 1 Code", '9100');
                                                                if studentmaster.FindFirst() then
                                                                    premed1 := 'AICASA'
                                                                else
                                                                    premed1 := '';


                                                                premed := '';
                                                                if (premed1 <> '') and (premed2 <> '') then begin
                                                                    premed := premed1 + ', ' + premed2;
                                                                end else
                                                                    premed := premed1 + premed2;

                                                                // ResidencyTxt := '';
                                                                // if Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED'] then
                                                                //     residencyTxt := 'No';

                                                                // if not (Residency_gRec1."Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED']) then
                                                                //     residencyTxt := 'Yes';


                                                                TempRecord_gRec.Field7 := graduationyear;
                                                                TempRecord_gRec.Field65 := premed;
                                                                TempRecord_gRec.Field66 := fiurotations;
                                                                TempRecord_gRec.Field71 := studenthonors."Honors Name";
                                                                TempRecord_gRec."Transcript End" := Residency_gRec1."Residency Type";

                                                                TempRecord_gRec.Insert();
                                                            end;

                                                        until Residency_gRec1.Next() = 0;
                                                    end;
                                                    ResidentYearFilter5 := Residency_gRec."Residency Year";
                                                end;

                                            until Residency_gRec.Next() = 0;
                                        end;


                                    end;
                                //     ResidentYearFilter4 := Residency_lRec."Residency Year";
                                // End;
                                until Residency_lRec.Next() = 0;
                            end;
                        end;
                        ResidentYearFilter3 := Residency1."Residency Year";
                    End;

                end;

                trigger OnPostDataItem()
                begin
                    TempRecord_gRec.Reset();
                    TempRecord_gRec.SetCurrentKey(Program);
                    TempRecord_gRec.Ascending(false);
                    TempRecord_gRec.SetRange(Select, true);
                    TempRecord_gRec.SetRange("Transcript End", 'NO');
                    IF TempRecord_gRec.FindSet() then begin
                        repeat
                            TempRecord_gRec1.Reset();
                            TempRecord_gRec1.SetCurrentKey(Field33);
                            TempRecord_gRec1.SetRange(Program, TempRecord_gRec.Program);
                            TempRecord_gRec1.SetRange(Select, true);
                            TempRecord_gRec.SetRange("Transcript End", 'NO');
                            IF TempRecord_gRec1.FindSet() then begin
                                repeat
                                    IF TempRecord_gRec1.Field33 = 1 then
                                        PlacementActualOrder += 1;
                                    IF TempRecord_gRec1.Field33 <> 1 then
                                        PlacementActualOrder += 1;
                                    TempRecord_gRec1.Field32 := PlacementActualOrder;
                                    TempRecord_gRec1.Select := false;

                                    TempRecord_gRec1.Modify();
                                until TempRecord_gRec1.Next() = 0;
                            end;
                        until TempRecord_gRec.Next() = 0;

                    end;
                end;

            }

            trigger OnPreDataItem()
            begin
                if GuiAllowed then
                    WindowDialog.Open('Fetching Data....\' + Text001Lbl);

                totalcount := "Student Master-CS".count;
            end;

            trigger OnAfterGetRecord()
            var
                studentdegree2: Record "Student Degree";
                EntryNo: Integer;
                globalhealthtrack: Text;
                fiurotations: text;
                EthnicityCode: Text;
                residencyTxt: text;
                premed: Text;
                premed1: Text;
                premed2: Text;
                ResidencySpecialty: Text;
                hospitalname: Text;
                hospitalcity: Code[20];
                hospitalstate: Code[20];
                hospitalcountry: Text;
                studentstatus: Code[20];
                studentcountry: Text;
                residencystatus: text;
                graduationyear: Text;
                residencyorder: Integer;
                residencyorder2: Integer;
                residencyorderlast: Text;
                nationalityname: Text;
                residencystate: Text;
                statedesc: text;
                placementtype: text;


            Begin
                LicenseTrackingState := '';
                LicenseTracking.Reset();
                LicenseTracking.SetCurrentKey("SLcM No.", State);
                LicenseTracking.SetRange("SLcM No.", "Student Master-CS"."No.");
                If LicenseTracking.FindSet() then begin
                    repeat
                        If LicenseTrackingState = '' then
                            LicenseTrackingState := LicenseTracking.State
                        Else
                            LicenseTrackingState += '/' + LicenseTracking.State;
                    until LicenseTracking.Next() = 0;
                end;

                LicenseType := '';
                LicenseTracking.Reset();
                LicenseTracking.SetRange("SLcM No.", "Student Master-CS"."No.");
                IF LicenseTracking.FindFirst() then
                    LicenseType := LicenseTracking."License Type";

                counter += 1;
                if GuiAllowed then
                    WindowDialog.Update(1, "Student Master-CS"."No." + ' - ' + format(counter) + ' of ' + format(totalcount));

                Clear(studentdegree2);
                studentdegree2.Reset();
                studentdegree2.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                studentdegree2.SetRange("Degree Code", 'DOC');
                if not studentdegree2.FindFirst() then
                    CurrReport.Skip();

                Residency_gREc2.Reset();
                Residency_gREc2.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                IF Not Residency_gREc2.FindFirst() then begin
                    TempRecord_gRec.Reset();
                    IF TempRecord_gRec.FindLast() then
                        EntryNo := TempRecord_gRec."Entry No" + 1
                    Else
                        EntryNo := 1;

                    TempRecord_gRec.Init();
                    TempRecord_gRec."Entry No" := EntryNo;
                    TempRecord_gRec.Field2 := "Student Master-CS"."Original Student No.";
                    TempRecord_gRec.Field3 := "Student Master-CS"."Enrollment No.";
                    TempRecord_gRec.Field11 := "Student Master-CS"."First Name";
                    TempRecord_gRec.Field12 := "Student Master-CS"."Last Name";
                    TempRecord_gRec.Field4 := Format("Student Master-CS".Gender);

                    country.Reset();
                    country.SetRange(Code, "Student Master-CS".Nationality);
                    if country.FindFirst() then
                        TempRecord_gRec.Field14 := country.Nationality
                    else
                        TempRecord_gRec.Field14 := "Student Master-CS".Nationality;

                    EthnicityCode := '';
                    studentEthnicity.Reset();
                    studentEthnicity.SetRange("Student No.", "Student Master-CS"."No.");
                    if studentEthnicity.findset() then
                        repeat
                            if EthnicityCode = '' then
                                EthnicityCode := studentEthnicity."Ethnicity Name"
                            else
                                EthnicityCode += ', ' + studentEthnicity."Ethnicity Name";
                        until studentEthnicity.Next() = 0;

                    TempRecord_gRec.Field51 := EthnicityCode;

                    // Evaluate(TempRecord_gRec.Program, Residency1."Residency Year");
                    // TempRecord_gRec.Field38 := Residency1."Residency Placement Type";
                    // TempRecord_gRec.Field39 := Residency1."Residency Specialty";
                    // TempRecord_gRec.Field40 := Residency1."Residency Status";
                    PlacementActualOrder := 0;
                    PlacementActualOrder += 1;
                    TempRecord_gRec.Field32 := PlacementActualOrder;

                    // TempRecord_gRec.Field44 := Residency1."Hospital Name";
                    // TempRecord_gRec.Field46 := Residency1."Hospital City";
                    // TempRecord_gRec.Field47 := Residency1."Hospital State";

                    // country.Reset();
                    // country.SetRange(Code, Residency1."Hospital Country");
                    // if country.FindFirst() then
                    //     TempRecord_gRec.Field48 := country.Name;


                    TempRecord_gRec."Residency Preliminary" := 'No';//GAURAV//19//04//23

                    TempRecord_gRec."Licence State" := LicenseTrackingState;
                    TempRecord_gRec."Licence Type" := LicenseType;

                    TempRecord_gRec.Field49 := "Student Master-CS"."Alternate Email Address";
                    TempRecord_gRec."Student Last Name" := "Student Master-CS"."E-Mail Address";
                    TempRecord_gRec.Field64 := "Student Master-CS".Addressee + ' ' + "Student Master-CS".Address1 + ' ' + "Student Master-CS".Address2;
                    TempRecord_gRec.Field52 := "Student Master-CS"."Mobile Number";
                    TempRecord_gRec.Field55 := "Student Master-CS"."Phone Number";
                    TempRecord_gRec.Field54 := "Student Master-CS".City;

                    staterec.Reset();
                    staterec.SetRange(code, "Student Master-CS".State);
                    staterec.SetRange("Country/Region Code", "Student Master-CS"."Country Code");
                    if staterec.FindFirst() then
                        TempRecord_gRec.Field58 := staterec.Description;

                    TempRecord_gRec.Field5 := "Student Master-CS"."Post Code";
                    country.Reset();
                    country.SetRange(Code, "Student Master-CS"."Country Code");
                    IF country.FindFirst() then
                        TempRecord_gRec.Field59 := country.Name;

                    TempRecord_gRec.Field60 := "Student Master-CS".Status;
                    IF "Student Master-CS"."Course Code" = 'AUA-GHT' then
                        TempRecord_gRec."Enrollment No." := 'Yes'
                    Else
                        TempRecord_gRec."Enrollment No." := '';

                    Clear(studenthonors);
                    studenthonors.Reset();
                    studenthonors.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    if studenthonors.FindFirst() then;

                    fiurotations := '';
                    graduationyear := '';
                    studentdegree.Reset();
                    studentdegree.SetRange("Enrollment No.", "Enrollment No.");
                    studentdegree.SetRange("Degree Code", 'DOC');
                    if studentdegree.FindFirst() then begin
                        graduationyear := format(setgraduationdate(studentdegree.DateAwarded));
                        rosterledgerentry.Reset();
                        rosterledgerentry.SetRange("Enrollment No.", studentdegree."Enrollment No.");
                        rosterledgerentry.SetRange("Clerkship Type", rosterledgerentry."Clerkship Type"::Core);
                        rosterledgerentry.SetRange("Hospital Name", 'FIU-HWCOM');
                        rosterledgerentry.Setfilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', 'X', 'SC', 'TC', 'UC', 'F', 'R', 'M');
                        if rosterledgerentry.FindFirst() then begin
                            if rosterledgerentry.count > 5 then
                                fiurotations := 'Yes'
                            else
                                fiurotations := '';
                        end;
                    end;

                    premed2 := '';
                    premed1 := '';
                    studentgroup.Reset();
                    studentgroup.SetRange("Enrollment No.", "Student Master-CS"."Enrollment No.");
                    Studentgroup.SetRange("Groups Code", 'KMCIC');
                    if studentgroup.FindFirst() then
                        premed2 := 'KMCIC'
                    else
                        premed2 := '';

                    studentmaster.Reset();
                    studentmaster.SetRange("Original Student No.", "Student Master-CS"."Original Student No.");
                    studentmaster.SetFilter(Semester, '%1|%2|%3|%4', 'PREMED1', 'PREMED2', 'PREMED3', 'PREMED4');
                    studentmaster.SetRange("Global Dimension 1 Code", '9100');
                    if studentmaster.FindFirst() then
                        premed1 := 'AICASA'
                    else
                        premed1 := '';


                    premed := '';
                    if (premed1 <> '') and (premed2 <> '') then begin
                        premed := premed1 + ', ' + premed2;
                    end else
                        premed := premed1 + premed2;

                    ResidencyTxt := '';

                    TempRecord_gRec."Unique ID" := UserId();
                    TempRecord_gRec.Field7 := graduationyear;
                    TempRecord_gRec.Field65 := premed;
                    TempRecord_gRec.Field66 := fiurotations;
                    TempRecord_gRec.Field71 := studenthonors."Honors Name";
                    TempRecord_gRec."Transcript End" := residencyTxt;
                    TempRecord_gRec.Insert();

                end

            End;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    var
        TempRecord_gRec: Record "Temp Record";
        Residency_lRec: Record Residency;
        Residency_lRec1: Record Residency;
        studentEthnicity: Record "Student Ethnicity";
        staterec: Record "State SLcM CS";
        country: Record "Country/Region";
        studenthonors: Record "Student Honors";
        studentdegree: Record "Student Degree";
        TempRecord_gRec1: Record "Temp Record";
        studentmaster: Record "Student Master-CS";
        Residency_gRec: Record Residency;
        Residency_gRec1: Record Residency;
        Residency_gREc2: Record Residency;
        rosterledgerentry: Record "Roster Ledger Entry";
        studentgroup: Record "Student Group";
        LicenseTracking: Record "License Tracking";
        PlacementFieldOrder: Integer;
        LicenseType: Text;
        PlacementActualOrder: Integer;
        ResidentYearFilter: Text;
        ResidentYearFilter2: Text;
        ResidentYearFilter1: Text;
        ResidentYearFilter3: Text;
        ResidentYearFilter4: Text;
        ResidentYearFilter5: Text;

        counter: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Students No.     ############1################\';
        totalcount: Integer;
        SpecialityCount: Integer;
        SpecialityCount1: Integer;
        SpecialityCount2: Integer;
        SpecialityCount3: Integer;
        SpecialityCount4: Integer;
        LicenseTrackingState: Text;



    trigger OnPreReport()
    begin
        TempRecord_gRec.Reset();
        TempRecord_gRec.SetRange("Unique ID", UserId());
        TempRecord_gRec.DeleteAll();
    end;

    trigger OnPostReport()
    begin
        if GuiAllowed then
            WindowDialog.Close();

        TempRecord_gRec.Reset();
        TempRecord_gRec.SetRange("Unique ID", UserId());
        if TempRecord_gRec.FindFirst() then
            page.Run(50013, TempRecord_gRec);
    end;

    procedure setgraduationdate(dateawarded: Date) yearofgraduation: Integer
    begin
        if dateawarded = 0D then
            exit;

        if (dateawarded >= 20050701D) and (dateawarded <= 20060630D) then
            yearofgraduation := 2006
        else
            if (dateawarded >= 20060701D) and (dateawarded <= 20070630D) then
                yearofgraduation := 2007
            else
                if (dateawarded >= 20070701D) and (dateawarded <= 20080630D) then
                    yearofgraduation := 2008
                else
                    if (dateawarded >= 20080701D) and (dateawarded <= 20090630D) then
                        yearofgraduation := 2009
                    else
                        if (dateawarded >= 20090701D) and (dateawarded <= 20100630D) then
                            yearofgraduation := 2010
                        else
                            if (dateawarded >= 20100701D) and (dateawarded <= 20110630D) then
                                yearofgraduation := 2011
                            else
                                if (dateawarded >= 20110701D) and (dateawarded <= 20120630D) then
                                    yearofgraduation := 2012
                                else
                                    if (dateawarded >= 20120701D) and (dateawarded <= 20130630D) then
                                        yearofgraduation := 2013
                                    else
                                        if (dateawarded >= 20130701D) and (dateawarded <= 20140630D) then
                                            yearofgraduation := 2014
                                        else
                                            if (dateawarded >= 20140701D) and (dateawarded <= 20150630D) then
                                                yearofgraduation := 2015
                                            else
                                                if (dateawarded >= 20150701D) and (dateawarded <= 20160630D) then
                                                    yearofgraduation := 2016
                                                else
                                                    if (dateawarded >= 20160701D) and (dateawarded <= 20170630D) then
                                                        yearofgraduation := 2017
                                                    else
                                                        if (dateawarded >= 20170701D) and (dateawarded <= 20180630D) then
                                                            yearofgraduation := 2018
                                                        else
                                                            if (dateawarded >= 20180701D) and (dateawarded <= 20190630D) then
                                                                yearofgraduation := 2019
                                                            else
                                                                if (dateawarded >= 20190701D) and (dateawarded <= 20200630D) then
                                                                    yearofgraduation := 2020
                                                                else
                                                                    if (dateawarded >= 20200701D) and (dateawarded <= 20210630D) then
                                                                        yearofgraduation := 2021
                                                                    else
                                                                        if (dateawarded >= 20210701D) and (dateawarded <= 20220630D) then
                                                                            yearofgraduation := 2022
                                                                        else
                                                                            if (dateawarded >= 20220701D) and (dateawarded <= 20230630D) then
                                                                                yearofgraduation := 2023
                                                                            else
                                                                                if (dateawarded >= 20230701D) and (dateawarded <= 20240630D) then
                                                                                    yearofgraduation := 2024
                                                                                else
                                                                                    if (dateawarded >= 20240701D) and (dateawarded <= 20250630D) then
                                                                                        yearofgraduation := 2025;

        exit(yearofgraduation);
    end;


}
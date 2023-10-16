report 50074 "Country Wise Strength"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Country Wise Strength.rdl';
    PreviewMode = PrintLayout;
    ProcessingOnly = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE("Country Code" = FILTER(<> ''));
            PrintOnlyIfDetail = false;

            column(Filter_Caption1; Allfilters)
            {

            }
            column(CountryCode_StudentMasterCS; "Country Code")
            {
            }
            column(AcademicYear_StudentMasterCS; "Academic Year")
            {
            }
            column(NameasonCertificate_StudentMasterCS; "Name as on Certificate")
            {
            }
            column(CourseCode_StudentMasterCS; "Course Code")
            {
            }
            column(Section_StudentMasterCS; Section)
            {
            }
            column(Gender_StudentMasterCS; Gender)
            {
            }
            column(Pro1; Pro1)
            {
            }
            column(CountryName; CountryName)
            {
            }
            column(DimensionValue_Image; DimensionValue.Image)
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
            Column("ImageLogo"; RecEduSetup."Logo Image")
            {

            }
            column(ImageAUA; RecEduSetupAUA."Logo Image")
            {
            }
            column(ImageAICASA; RecEduSetupAICASA."Logo Image")
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange("Global Dimension 1 Code", InstituteCode);
                IF GraduationCode <> '' THEN
                    SetFilter(Graduation, GraduationCode);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
                IF YearCode <> '' THEN
                    SetFilter(Year, YearCode);
                IF AdmittedYearCode <> '' THEN
                    SetFilter("Admitted Year", AdmittedYearCode);

                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '9000');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);

                // IF "Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG' THEN
                //     Pro1 := 'B.Tech'
                // ELSE
                //     Pro1 := 'M.Tech / MCA'
            end;

            trigger OnAfterGetRecord()
            begin
                InstituteCodeFilter := '';
                GraduationCodeFilter := '';
                AcademicYearFilter := '';
                YearFilter := '';
                AdmittedYearFilter := '';
                AllFilters := '';

                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF GraduationCode <> '' then
                    GraduationCodeFilter := ', Graduation:' + Graduation;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";
                IF YearCode <> '' then
                    YearFilter := ', Year:' + Year;
                IF AdmittedYearCode <> '' then
                    AdmittedYearFilter := ', Admitted Year:' + "Admitted Year";

                AllFilters := InstituteCodeFilter + GraduationCodeFilter + AcademicYearFilter + YearFilter + AdmittedYearFilter;

                CountryName := '';
                CountryRegion.Reset();
                CountryRegion.SETRANGE(Code, "Country Code");
                IF CountryRegion.findfirst() THEN
                    CountryName := CountryRegion.Name;

                RecEduSetupAUA.Reset();
                RecEduSetupAUA.SetRange("Global Dimension 1 Code", '9000');
                IF RecEduSetupAUA.FindFirst() then
                    RecEduSetupAUA.CALCFIELDS("Logo Image");

                RecEduSetupAICASA.Reset();
                RecEduSetupAICASA.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetupAICASA.FindFirst() then
                    RecEduSetupAICASA.CALCFIELDS("Logo Image");

                If "Student Master-CS"."Course Code" <> '' then
                    IF RecCourseMaster.GeT("Student Master-CS"."Course Code") then
                        Pro1 := RecCourseMaster.Description;


            end;
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
                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institute Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field(Graduation; GraduationCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Graduation';
                        TableRelation = "Graduation Master-CS";
                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        TableRelation = "Academic Year Master-CS";
                    }
                    field(Year; YearCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                        TableRelation = "Year Master-CS";
                    }
                    field("Admitted Year"; AdmittedYearCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Admitted Year';
                        TableRelation = "Academic Year Master-CS";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        IF InstituteCode = '' THEN
            ERROR('Institute Code must have a value in it');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    End;

    var
        CountryRegion: Record "Country/Region";
        DimensionValue: Record "Dimension Value";
        RecEduSetup: Record "Education Setup-CS";

        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        RecCourseMaster: Record "Course Master-CS";
        Pro1: Text[1024];

        CountryName: Text[50];
        AcademicYearFilter: Text;
        AllFilters: Text;
        InstituteCodeFilter: Code[20];
        AcademicYear: Code[20];
        InstituteCode: Code[20];
        GraduationCode: Code[20];
        GraduationCodeFilter: Code[20];

        YearCode: Code[10];
        YearFilter: Code[10];

        AdmittedYearCode: Code[20];
        AdmittedYearFilter: Code[20];


}


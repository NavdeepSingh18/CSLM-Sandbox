table 50414 "Rotation Offers"
{
    DataClassification = CustomerContent;
    Caption = 'Rotation Offer Header';

    fields
    {
        field(1; "Offer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Offer No.';
            trigger OnValidate()
            begin
                NoSeriesManagement.TestManual(GetNoSeriesCode());
                "No. Series" := '';
            end;
        }
        field(2; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }

        field(6; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Subject Master-CS".Code where(Code = field("Core Subjects for Elective"), "Type of Subject" = filter(Core), "Level Description" = filter("Level 2 Clinical Rotation"));

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Course Description" := '';
                "Elective Course Code" := '';
                "Rotation Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);

                IF "Course Code" <> '' then begin
                    SubjectMaster.Reset();
                    SubjectMaster.SetRange(Code, "Course Code");
                    if SubjectMaster.findfirst() then begin
                        SubjectMaster.TestField(Duration);
                        "Course Description" := SubjectMaster.Description;
                        "Rotation Description" := SubjectMaster.Description;

                        TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                        Evaluate(NoOfWeeks, TextNoofWeeks);
                        Validate("No. of Weeks", NoOfWeeks);
                    end;
                end;
            end;
        }
        field(7; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(8; "Course Prefix"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix';
            TableRelation = "Subject Prefix".Code;
            trigger OnValidate()
            begin
                Validate("Elective Course Code");
            end;
        }

        field(9; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
            TableRelation = if ("Hospital ID" = filter(<> '')) "Hospital Inventory"."Course Code" where("Hospital ID" = field("Hospital ID"), "Clerkship Type" = filter(Elective))
            else
            "Subject Master-CS".Code where("Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"));

            trigger OnValidate()
            var
                HospitalInventory: Record "Hospital Inventory";
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Course Description" := '';
                "Rotation Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);
                Validate("No. of Seats", 0);

                if "Elective Course Code" <> '' then begin
                    SubjectMaster.Reset();
                    SubjectMaster.SetRange(Code, "Elective Course Code");
                    if SubjectMaster.FindFirst() then begin
                        "Course Description" := SubjectMaster.Description;
                        "Rotation Description" := SubjectMaster.Description;
                        if "Course Prefix" <> '' then
                            "Rotation Description" := "Course Prefix" + ' - ' + SubjectMaster.Description;
                        TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                        Evaluate(NoOfWeeks, TextNoofWeeks);
                        Validate("No. of Weeks", NoOfWeeks);
                    end;
                end;

                if ("Elective Course Code" <> '') and ("Hospital ID" <> '') then begin
                    HospitalInventory.Reset();
                    HospitalInventory.SetRange("Hospital ID", "Hospital ID");
                    HospitalInventory.SetRange("Course Code", "Elective Course Code");
                    if HospitalInventory.FindLast() then
                        Validate("No. of Seats", HospitalInventory.Seats);
                    // if HospitalInventory."Course Prefix" <> "Course Prefix" then
                    //     Message('Course Prefix %1 is not same as the mapped in Hospital Inventory i.e. %2 (%3) with the Elective Couse Code %4 (%5)', "Course Prefix", "Hospital ID", "Hospital Name", "Elective Course Code", "Rotation Description");
                    // if HospitalInventory."Course Prefix" <> "Course Prefix" then
                    //     if not Confirm('Are you sure you want to go with the same Course Prefix?') then
                    //         Error('Action stopped due to respact the Warning.');
                    //end;
                end;
            end;
        }
        field(10; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
            Editable = false;
        }

        field(11; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            var
                Date_1: Record Date;
            begin
                "End Date" := 0D;
                if "Start Date" <> 0D then begin
                    if "Start Date" < WorkDate() then
                        Error('Start Date of a rotation cannot be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation Start Date must be Monday.');
                    Validate("No. of Weeks");
                end;
            end;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }

        field(13; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            BlankZero = true;
            trigger OnValidate()
            var
                PeriodLength: DateFormula;
            begin
                if "Start Date" <> 0D then begin
                    EVALUATE(PeriodLength, Format("No. of Weeks") + 'W-3D');
                    "End Date" := CALCDATE(PeriodLength, "Start Date");
                end
                else
                    "End Date" := 0D;
            end;
        }

        field(14; "Cordination ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cordination ID';
            TableRelation = User."User Name";
            Editable = false;
        }

        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }

        field(16; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ",Confirmed,Completed,Cancelled,Closed;
            trigger OnValidate()
            begin
                "Status By" := UserId;
                "Status On" := Today;
            end;
        }

        field(18; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }
        field(20; "Status On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Status By';
            Editable = false;
        }
        field(21; "Visible on Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Visible on Portal';
        }
        field(30; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
            TableRelation = Vendor."No." where("Vendor Sub Type" = filter(Hospital), "Elective Rotation Applicable" = const(true));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
                HospitalInventory: Record "Hospital Inventory";
            begin
                "Hospital Name" := '';
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    "Hospital Name" := Vendor.Name;

                Validate("No. of Seats", 0);

                Validate("Course Code", '');
                Validate("Course Prefix", '');
                Validate("Elective Course Code", '');

                if "Hospital ID" <> '' then begin
                    HospitalInventory.Reset();
                    HospitalInventory.SetRange("Hospital ID", "Hospital ID");
                    HospitalInventory.SetRange("Course Code", "Elective Course Code");
                    if HospitalInventory.FindLast() then
                        Validate("No. of Seats", HospitalInventory.Seats);
                end;
            end;
        }
        field(31; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }

        field(33; "No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Seats';
            DecimalPlaces = 0;
            MinValue = 0;
            trigger OnValidate()
            begin
                Validate("Total No. of Seats");
            end;
        }
        field(34; "Maximum Waitlist Students"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Waitlist Students';
            DecimalPlaces = 0;
            trigger OnValidate()
            begin
                Validate("Total No. of Seats");
            end;
        }
        field(35; "Total No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Seats';
            Editable = false;
            DecimalPlaces = 0;
            trigger OnValidate()
            begin
                "Total No. of Seats" := "No. of Seats" + "Maximum Waitlist Students";
            end;
        }
        field(60000; "No. of Students Applied"; Integer)
        {
            Caption = 'No. of Students Applied';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("Rotation Offer Application" where("Offer No." = field("Offer No."), Status = filter(Confirmed)));
        }
        field(60001; "Core Subjects for Elective"; Code[100])
        {
            Caption = 'Core Subjects for Elective';
            Editable = false;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Offer No.")
        {
            Clustered = true;
        }
        key(StartDate; "Start Date")
        {
            Clustered = false;
        }
    }

    fieldgroups
    {

    }

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Offer No.", "No. Series");
        "Status By" := UserId;
        "Status On" := Today;
    end;

    trigger OnModify()
    begin

    end;


    /// <summary> 
    /// Description for GetNoSeriesCode.
    /// </summary>
    /// <returns>Return variable "SeriesCode" of type Code[20].</returns>
    local procedure GetNoSeriesCode() SeriesCode: Code[20];
    var
        EducationSetupCS: Record "Education Setup-CS";
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if EducationSetupCS.Find('-') then begin
            EducationSetupCS.TestField("Elective Rotation Offer Nos");
            SeriesCode := EducationSetupCS."Elective Rotation Offer Nos";
            exit(SeriesCode);
        end;
    end;

    /// <summary> 
    /// Description for ApplyForRotation.
    /// </summary>
    procedure ApplyForRotation()
    var
        RotationOfferApplication: Record "Rotation Offer Application";
        RotationOfferApplnCard: Page "Rotation Offer Appln Card";
        LineNo: Integer;
    begin
        RotationOfferApplication.Reset();
        RotationOfferApplication.SetRange("Offer No.", "Offer No.");
        if RotationOfferApplication.FindLast() then
            LineNo := RotationOfferApplication."Line No.";

        RotationOfferApplication.Init();
        RotationOfferApplication.Validate("Offer No.", "Offer No.");
        RotationOfferApplication."Line No." := LineNo + 10000;
        RotationOfferApplication.Insert(true);
        Commit();
        Clear(RotationOfferApplnCard);
        RotationOfferApplnCard.SetRecord(RotationOfferApplication);
        RotationOfferApplnCard.SetTableView(RotationOfferApplication);
        RotationOfferApplnCard.RunModal();
    end;
}
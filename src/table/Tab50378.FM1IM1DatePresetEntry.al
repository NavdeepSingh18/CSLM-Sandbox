table 50378 "FM1/IM1 Date Preset Entry"
{
    DataClassification = CustomerContent;
    Caption = 'FM1/IM1 Date Preset Entry';
    LookupPageId = "FM1_IM1 Date Preset List";
    fields
    {
        field(1; "Preset No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Preset No.';
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
            TableRelation = "Subject Master-CS".Code;

            trigger OnValidate()
            var
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Course Description" := '';
                NoOfWeeks := 0;
                Validate("No. of Weeks", NoOfWeeks);
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
        }
        field(7; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
            Editable = false;
        }
        field(8; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
        }
        field(11; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            var
                Date_1: Record Date;
                PeriodLength: DateFormula;
            begin
                TestField("Course Code");
                "Document Due Date" := 0D;

                if "Start Date" <> 0D then begin
                    if "Start Date" < WorkDate() then
                        Error('Start Date of FM1/IM1 Date Preset cannot be less than %1.', WorkDate());

                    Date_1.Reset();
                    Date_1.SetRange("Period Type", Date_1."Period Type"::Date);
                    Date_1.SetRange("Period Start", "Start Date");
                    if Date_1.FindFirst() then;

                    if Date_1."Period Name" <> 'Monday' then
                        Error('Rotation start date must be Monday.');
                    EVALUATE(PeriodLength, '-91D');
                    "Document Due Date" := CALCDATE(PeriodLength, "Start Date");
                end;

                CheckPeriodOverLapping();

                Validate("No. of Weeks");
            end;
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
                "End Date" := 0D;
                if "Start Date" <> 0D then begin
                    EVALUATE(PeriodLength, Format("No. of Weeks") + 'W-3D');
                    "End Date" := CALCDATE(PeriodLength, "Start Date");
                end;
            end;
        }
        field(12; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(14; "Document Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Due Date';
            Description = '10 Weeks Prior to Start of the Rotation.';
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(16; "No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Seats';
            MinValue = 0;
        }
        field(17; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = "Open","Confirmed";
            trigger OnValidate()
            begin
                "Confirmed By" := '';
                "Confirmed On" := 0D;
                CheckPeriodOverLapping();
                if Status = Status::Confirmed then begin
                    "Confirmed By" := UserId;
                    "Confirmed On" := Today;
                end;
            end;
        }
        field(18; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(53; "Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(54; "Special Accommodation"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Not Required","Required";
        }
        field(55; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

        field(56; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(PK; "Preset No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Preset No.", "Start Date", "No. of Weeks", "End Date", "Document Due Date", "Academic Year")
        {
        }
    }

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Preset No.", "No. Series");
        "Created By" := UserId;
        "Created On" := Today;
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
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
            EducationSetupCS.TestField("FM1/IM1 Date Preset Nos.");
            SeriesCode := EducationSetupCS."FM1/IM1 Date Preset Nos.";
        end;
        exit(SeriesCode);
    end;

    procedure CheckPeriodOverLapping()
    var
        FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
    begin
        FM1IM1DatePresetEntry.Reset();
        FM1IM1DatePresetEntry.SetFilter("Preset No.", '<>%1', "Preset No.");
        FM1IM1DatePresetEntry.SetRange("Course Code", "Course Code");
        if FM1IM1DatePresetEntry.FindSet() then
            repeat
                if ("Start Date" >= FM1IM1DatePresetEntry."Start Date") and ("Start Date" <= FM1IM1DatePresetEntry."End Date") then
                    Error('Start Date %1 is lying within the Period of already created Preset No. %2 - (%3 to %4).', "Start Date", FM1IM1DatePresetEntry."Preset No.", FM1IM1DatePresetEntry."Start Date", FM1IM1DatePresetEntry."End Date");
            until FM1IM1DatePresetEntry.Next() = 0;
    end;
}
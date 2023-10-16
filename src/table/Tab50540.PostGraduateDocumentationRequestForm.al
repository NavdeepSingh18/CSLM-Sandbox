table 50540 "Post Grad. Doc. Req. Form"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Post Grd. Doc. Req. Form";
    // LookupPageId = "Post Grd. Doc. Req. Form";
    Caption = 'Post Graduate Documentation Request Form';

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
            begin
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."First Name" + '' + StudentMasterCS."Last Name";
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "States for Licensure"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Type of Licensure Permit"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Documents Needed"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Other Information Needed"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Recipient Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Recipient Email"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Recipient Address"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Processing Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Pending,Completed,Rejected;
        }
        field(15; "Processed By"; Code[20])
        {
            DataClassification = CustomerContent;
            editable = false;
            // TableRelation = Employee;
        }
        field(16; "Processing Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(22; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(23; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Entry From Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Process Status"; Option)
        {
            Caption = 'Processing Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Submitted;
        }
    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := true;
        usersetup.get(UserId());
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", '9000');
        if EduSetup.FindFirst() then begin
            EduSetup.TESTFIELD("Application No For Doc.");
            NoSeriesMngt.InitSeries(EduSetup."Application No For Doc.", xRec."No. Series", 0D, "Application No", Rec."No. Series");
        end;

        Validate("Process Status", "Process Status"::Submitted);
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        If xRec.Updated = Updated then
            Updated := true;
    end;

    var
        usersetup: Record "User Setup";
        SelectNoSeriesAllow: Boolean;
        EduSetup: Record "Education Setup-CS";
        NoSeriesRec: Record "No. Series";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    //code for request no - No series +
    procedure AssistEdit("Documentation Req": Record "Post Grad. Doc. Req. Form"): Boolean
    var
        Rec_DocumentationReq: Record "Post Grad. Doc. Req. Form";
        NoSerMgnt: Codeunit NoSeriesManagement;
    begin
        with Rec_DocumentationReq do begin
            Copy(Rec);
            usersetup.Get(UserId());
            EduSetup.Reset();
            EduSetup.SetRange("Global Dimension 1 Code", '9000');
            if EduSetup.FindFirst() then begin
                EduSetup.TestField("Application No For Doc.");
                if NoSerMgnt.SelectSeries(EduSetup."Application No For Doc.", "Documentation Req"."No. Series", "No. Series") then begin
                    NoSerMgnt.SetSeries("Application No");
                    Rec := Rec_DocumentationReq;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure TestNumSer()
    var
        Check: Boolean;
    begin
        EduSetup.Get();
        Check := false;
        if not Check then
            EduSetup.TestField("Application No For Doc.");
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        Check: Boolean;
        NoSeriesCode: Code[20];
    begin
        EduSetup.Get();
        Check := false;
        if Check then
            exit;
        NoSeriesCode := EduSetup."Application No For Doc.";
        exit(NoSeriesMngt.GetNoSeriesWithCheck(NoSeriesCode, selectNoSeriesAllow, "No. Series"))
    end;

    procedure InitInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            if "Application No" = '' then begin
                TestNumSer();
                NoSeriesMngt.InitSeries(GetNoSeriesCode(), xRec."No. Series", Today, "Application No", "No. Series");
            end;
        initRecord();
    end;

    procedure InitRecord()
    var
        IsHandled: Boolean;
    begin
        EduSetup.Get();
        IsHandled := false;
        if not IsHandled then
            NoSeriesMngt.SetDefaultSeries("No. Series", EduSetup."Application No For Doc.");
    end;
    //code for request no - No series -
}
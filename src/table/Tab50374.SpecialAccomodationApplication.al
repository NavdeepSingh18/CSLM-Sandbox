table 50374 "Spcl Accommodation Application"
{
    DataClassification = CustomerContent;
    Caption = 'Special Accommodation Application';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
            Editable = false;
        }
        field(2; "Application Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Type';
            OptionMembers = " ","Clinical Rotation","Examination";
        }

        field(5; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "First Name" := '';
                "Middle Name" := '';
                "Last Name" := '';
                "Student Name" := '';
                "Enrollment No." := '';
                Semester := '';
                "Academic Year" := '';
                "Clinical Cordinator ID" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then begin
                    "First Name" := StudentMaster."First Name";
                    "Middle Name" := StudentMaster."Middle Name";
                    "Last Name" := StudentMaster."Last Name";
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "Academic Year" := StudentMaster."Academic Year";
                    Semester := StudentMaster.Semester;
                    "Clinical Cordinator ID" := StudentMaster."Clinical Coordinator";
                    "Global Dimension 1 Code" := StudentMaster."Global Dimension 1 Code";
                end;
            end;
        }
        field(6; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(7; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(8; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(9; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(10; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(11; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(12; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(14; "Clinical Cordinator ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Cordinator ID';
            Editable = false;
        }
        field(15; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Comments"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Comments';
        }
        field(29; "Clinical Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Reference No.';
        }
        field(30; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Created By';
        }

        field(31; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Created On';
        }
        field(32; "Send for Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Send for Approval';
        }
        field(33; "Send for Approval By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Send for Approval By';
        }
        field(34; "Send for Approval On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Send for Approval Date';
        }
        field(35; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = " ","Pending for Approval","Approved","Rejected";
            Caption = 'Approval Status';

            trigger OnValidate()
            begin
                "Approval Status By" := '';
                "Approval Status On" := 0D;
                if "Approval Status" IN ["Approval Status"::Approved, "Approval Status"::Rejected] then begin
                    "Approval Status By" := UserId;
                    "Approval Status On" := Today;
                    Modify();
                end;
            end;
        }
        field(36; "Approval Status By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Approval Status By';
        }
        field(37; "Approval Status On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Approval Status On';
        }

        field(47; "Reject Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Special Accommodation Rejection"));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Reject Reason Description" := '';
                ReasonCode.Reset();
                if ReasonCode.Get("Reject Reason Code") then
                    "Reject Reason Description" := ReasonCode.Description;
            end;
        }
        field(48; "Reject Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason Description';
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(Sorting_1; "Send for Approval")
        {
            Clustered = false;
        }
        key(Sorting_2; "Approval Status On")
        {
            Clustered = false;
        }
    }

    var
        NoSeriesManagement: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        NoSeriesManagement.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "Application No.", "No. Series");
        "Created By" := UserId;
        "Created On" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
    begin
        StdSplAccommodationCategory.Reset();
        StdSplAccommodationCategory.SetRange("Application No.", "Application No.");
        if StdSplAccommodationCategory.FindSet() then
            repeat
                StdSplAccommodationCategory.Delete();
            until StdSplAccommodationCategory.Next() = 0;
    end;

    trigger OnRename()
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
            if "Application Type" = "Application Type"::"Clinical Rotation" then begin
                EducationSetupCS.TestField("Clinical SPL Considration Nos.");
                SeriesCode := EducationSetupCS."Clinical SPL Considration Nos.";
            end;

            if "Application Type" = "Application Type"::Examination then begin
                EducationSetupCS.TestField("Exam SPL Considration Nos.");
                SeriesCode := EducationSetupCS."Exam SPL Considration Nos.";
            end;
            exit(SeriesCode);
        end;
    end;
}
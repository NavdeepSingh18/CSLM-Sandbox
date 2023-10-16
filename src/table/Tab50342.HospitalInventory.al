table 50342 "Hospital Inventory"
{
    DataClassification = ToBeClassified;
    Caption = 'Hospital Inventory';

    fields
    {
        field(1; "Hospital ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Hospital ID';
            TableRelation = Vendor."No." where("Vendor Sub Type" = const("Hospital"));
            trigger OnValidate()
            var
                Vendor: Record Vendor;

            begin
                "Hospital Name" := '';
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    "Hospital Name" := Vendor.Name;
            end;
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(4; Type; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
            OptionMembers = " ",Listing,Inventory;
        }
        field(5; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
        }
        field(6; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";

            trigger OnValidate()
            var
                EducationSetupCS: Record "Education Setup-CS";
                SubjectMasterCS: Record "Subject Master-CS";
            begin
                if "Clerkship Type" = "Clerkship Type"::"FM1/IM1" then begin
                    Type := Type::Inventory;
                    EducationSetupCS.Reset();
                    EducationSetupCS.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                    if EducationSetupCS.FindFirst() then
                        EducationSetupCS.TestField("FM1/IM1 Subject Code");

                    SubjectMasterCS.Reset();
                    SubjectMasterCS.SetRange(Code, EducationSetupCS."FM1/IM1 Subject Code");
                    if SubjectMasterCS.FindFirst() then
                        Validate("Course Code", SubjectMasterCS.Code);
                end
                else
                    Type := Type::Listing;
            end;
        }
        field(8; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = if ("Clerkship Type" = filter(Core)) "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Level Description" = filter("Level 2 Clinical Rotation"))
            else
            if ("Clerkship Type" = filter(Elective)) "Subject Master-CS".Code where("Type of Subject" = filter(Elective), "Level Description" = filter("Level 2 Elective Rotation"))
            else
            if ("Clerkship Type" = filter("FM1/IM1")) "Subject Master-CS".Code;

            trigger OnValidate()
            var
                EducationSetupCS: Record "Education Setup-CS";
                SubjectMaster: Record "Subject Master-CS";
                NoOfWeeks: Integer;
                TextNoofWeeks: Text;
            begin
                "Course Description" := '';
                Validate("Course Rotation Week", 0);
                SubjectMaster.Reset();
                SubjectMaster.SetRange(Code, "Course Code");
                if SubjectMaster.Find('-') then begin
                    SubjectMaster.TestField(Duration);
                    TextNoofWeeks := DelChr(Format(SubjectMaster.Duration), '=', 'DWMYQ');
                    "Course Description" := SubjectMaster.Description;
                    Evaluate(NoOfWeeks, TextNoofWeeks);
                    Validate("Course Rotation Week", NoOfWeeks);
                end;

                if "Clerkship Type" = "Clerkship Type"::"FM1/IM1" then begin
                    EducationSetupCS.Reset();
                    EducationSetupCS.SetRange("Global Dimension 1 Code", '9000');
                    if EducationSetupCS.FindFirst() then;

                    if StrPos(EducationSetupCS."FM1/IM1 Secondary Subjects", "Course Code") = 0 then
                        Error('Subject Code must be in %1 for the Clerkship Type %2.', EducationSetupCS."FM1/IM1 Secondary Subjects", "Clerkship Type");
                end;
            end;
        }
        field(9; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }

        field(11; "Course Rotation Week"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Rotation Week';
        }

        field(14; "Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Seats';
            DecimalPlaces = 0;
            MinValue = 0;
            trigger OnValidate()
            begin
                "Available Seats" := Seats - "Consumed Seats";
            end;
        }
        field(15; "Consumed Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Consumed Seats';
            DecimalPlaces = 0;
            Editable = false;
        }
        field(16; "Available Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Available Seats';
            DecimalPlaces = 0;
            Editable = false;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(19; "Block Reason Code"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Block Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter("Inventory Block"));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                "Block Reason" := '';
                if ReasonCode.Get("Block Reason Code") then
                    "Block Reason" := ReasonCode.Description;
            end;
        }
        field(20; "Block Reason"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Block Reason';
        }
        field(21; "Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ","Allowed","Blocked";
        }
        field(22; "Non-Affiliated Hospital"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Affiliated Hospital';
            Editable = false;
        }
        field(24; "Course Prefix"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Prefix';
            TableRelation = "Subject Prefix".Code;
        }
        field(25; "Contract Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Start Date';
        }
        field(26; "Contract End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract End Date';
        }
        field(27; "Elective Required"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Required';
        }
        field(28; "Elective Mandatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Mandatory';

            trigger OnValidate()
            var
                POS: Integer;
            begin
                if StrPos("Course Description", 'Sur') > 0 then
                    POS := StrPos("Course Description", 'Sur');
                if StrPos("Course Description", 'SUR') > 0 then
                    POS := StrPos("Course Description", 'SUR');

                if POS = 0 then
                    Error('Elective Mandatory can be marked only in case of Core Surgery.');
            end;
        }
        field(30; "Blocked By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Block By';
        }
        field(31; "Blocked On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Block On';
        }
        field(32; "Unblock By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unblock By';
        }
        field(33; "Unblock On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Unblock On';
        }
    }
    keys
    {
        key(PK; "Hospital ID", "Academic Year", "Start Date", "Clerkship Type", "Course Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Hospital ID", "Hospital Name", "Course Code", "Course Description", "Clerkship Type", "Academic Year")
        {
        }
    }

    trigger OnInsert()
    var
        Vendor: Record Vendor;
    begin
        "Non-Affiliated Hospital" := false;
        Vendor.Reset();
        if Vendor.Get("Hospital ID") then begin
            "Hospital Name" := Vendor.Name;
            "Non-Affiliated Hospital" := Vendor."Non-Affiliated Hospital";
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}
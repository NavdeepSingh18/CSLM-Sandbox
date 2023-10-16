tableextension 50000 "ExtendsVendor" extends Vendor
{
    fields
    {
        field(50000; "Vendor Sub Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Sub Type';
            OptionMembers = "Vendor","Hospital","Property Owner";
        }
        field(50001; "Latitude"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Latitude';
            DecimalPlaces = 8;
        }
        field(50002; "Longitude"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Longitude';
            DecimalPlaces = 8;
        }
        field(50003; "ACGME No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ACGME #';
        }
        field(50004; "Residency"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Residency';
        }
        field(50005; "System Ref. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'System Ref. No.';
        }
        field(50006; "FM1/IM1 Rotation Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Rotation Applicable';
        }
        field(50007; "Preffered for GHT Students"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Preffered for GHT Students';
        }
        field(50008; "FIU Hospital"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Hospital';
        }

        field(50009; "Non-Affiliated Hospital"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Affiliated Hospital';
            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                HospitalInventory: Record "Hospital Inventory";
            begin
                UserSetup.Reset();
                if UserSetup.Get(UserId) then;

                if UserSetup."Clinical Administrator" = false then
                    Error('You are not Authorised Uncheck Non-Affiliated Hospital');

                if "Non-Affiliated Hospital" = true then
                    if "System Ref. No." = '' then
                        Error('Hospital No. %1 can not be Marked as Non-Affliated Hospital');

                "LCME Sponsored" := "Non-Affiliated Hospital";

                HospitalInventory.Reset();
                HospitalInventory.SetRange("Hospital ID", "No.");
                if HospitalInventory.FindFirst() then
                    repeat
                        HospitalInventory."Non-Affiliated Hospital" := "Non-Affiliated Hospital";
                        HospitalInventory.Modify();
                    until HospitalInventory.Next() = 0;
            end;
        }
        field(50010; "LCME Sponsored"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'LCME Sponsored';
        }
        field(50011; Accreditation; Option)
        {
            OptionMembers = " ",ACGME,AOA,"None";
            DataClassification = CustomerContent;
        }
        field(50012; "Sponsoring Institution"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Sponsored Programs"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50014; "DME Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "DME Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50016; "DME Email"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(50017; "Supervising Physician Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50018; "Superviser Phone No."; Text[20])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(50019; "Superviser Email"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(50020; "DME Code"; Code[20])
        {
            TableRelation = "Business Contact Relation"."Contact No." where("No." = field("No."));
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                "DME Name" := '';
                "DME Email" := '';
                "DME Phone No." := '';

                Contact.Reset();
                if Contact.Get("DME Code") then begin
                    "DME Name" := Contact.Name;
                    "DME Email" := Contact."E-Mail";
                    "DME Phone No." := Contact."Phone No.";
                end;
            end;
        }
        // field(50021; "State Code"; Code[10])
        // {
        //     TableRelation = "State SLcM CS".Code;
        //     DataClassification = CustomerContent;
        // }
        field(50022; Specialty; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(50023; Extension; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50024; "Primary Contact"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact."No.";
            Caption = 'Primary Contact';
            trigger OnValidate()
            var
                Contact: Record Contact;
            begin
                "Primary Contact Name" := '';
                Contact.Reset();
                if Contact.Get("Primary Contact") then
                    "Primary Contact Name" := Contact.Name;
            end;
        }
        field(50025; "Primary Contact Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50026; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50027; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50030; "Preffered for International"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Preffered for International Students';
        }
        field(50031; "Elective Rotation Applicable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Rotation Applicable';
        }
        field(50035; "FM1/IM1 Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Cost';
        }
        field(50036; "Core Cost"; Decimal)
        {

            DataClassification = CustomerContent;
            Caption = 'Core Cost';
        }
        field(50037; "Elective Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Cost';
        }
        //CSPL-00307-ACGME - Start
        field(50038; "Program Director"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50039; "Accreditation Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Clinical Rotations Exist"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Roster Scheduling Line" where("Hospital ID" = field("No.")));
        }
    }

    trigger OnInsert()
    Begin
        Inserted := True;
    End;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := True;
    end;
}
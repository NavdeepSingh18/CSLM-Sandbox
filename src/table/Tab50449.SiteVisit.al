table 50449 "Site Visit"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Site Visit List";
    // LookupPageId = "Site Visit List";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;

            Trigger OnValidate()
            Var
                EducationSetupCS: Record "Education Setup-CS";
                NoSeriesManagement: Codeunit NoSeriesManagement;
            Begin
                IF Rec."Document No." <> xRec."Document No." then begin
                    EducationSetupCS.Reset();
                    IF EducationSetupCS.FindFirst() then;
                    NoSeriesManagement.TestManual(EducationSetupCS."Site Visit Nos");
                    "No. Series" := '';
                end;

            End;

        }
        Field(2; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(3; "User ID"; Text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
            Caption = 'Visitor ID';

            Trigger OnValidate()
            var
                Employee_lRec: Record Employee;
            begin
                If "User ID" <> '' then begin
                    Employee_lRec.Reset();
                    IF Employee_lRec.Get("User ID") then
                        "Visitor Name" := Employee_lRec.FullName();
                end Else
                    "Visitor Name" := '';
            end;
        }
        Field(4; "Visit Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor where("Vendor Sub Type" = filter(Hospital));

            trigger OnValidate()
            Var
                Vendor_lRec: Record Vendor;
            Begin
                If "Hospital ID" <> '' then begin
                    Vendor_lRec.Reset();
                    IF Vendor_lRec.Get("Hospital ID") then
                        "Hospital Name" := Vendor_lRec.Name;
                end Else
                    "Hospital Name" := '';

            End;
        }

        field(6; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(7; "Department Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Person Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Visit Reason"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter(Visit));
        }
        field(10; Inference; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inference Master" where(Blocked = filter(false));
        }
        field(11; "Created By"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(12; Speciality; Code[20])
        {
            DataClassification = CustomerContent;
            //Description = 'Not in Used';
            //ObsoleteState = Pending;
            trigger OnLookup()
            Var
                HospitalInventory_lRec: Record "Hospital Inventory";

            Begin
                HospitalInventory_lRec.Reset();
                HospitalInventory_lRec.SetRange("Clerkship Type", HospitalInventory_lRec."Clerkship Type"::Core);
                HospitalInventory_lRec.SetRange("Hospital ID", "Hospital ID");
                IF Page.RunModal(Page::"Hospital Inventory", HospitalInventory_lRec) = Action::LookupOK then begin
                    Validate(Speciality, HospitalInventory_lRec."Course Code");
                    Validate("Course Description", HospitalInventory_lRec."Course Description");
                end;

            End;

            Trigger OnValidate()
            begin
                If Speciality = '' then
                    "Course Description" := '';
            end;
        }
        field(13; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(14; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(15; "Inserted By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(16; "Inserted On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(17; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(18; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        Field(19; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        Field(21; "Visitor Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Date of Visit"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Name of the Institute"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Number of Beds"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Street Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; City; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; State; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(28; Country; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(29; "Zip Code"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Approved ACGME Resiency Program(s)"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(31; "Other Services"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "DME First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "DME Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "DME Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "DME Phone with Area Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'DME Phone';
        }
        field(36; "Dept Chairperson First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Dept Chairperson Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Dept Chairperson Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Dept Chairperson Phone with Area Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(40; "Program Director First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Program Director Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Program Director Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Program Director Phone with Area Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(44; "Clerkship Director First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Clerkship Director Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Clerkship Director Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Clerkship Director Phone with Area Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(58; "Student Preceptor Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Student Coordinator Contact"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Number of Clinical Faculty"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Formal Lectures"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Informal Teaching"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Faculty Supervision"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Faculty Assessment of Students"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "General Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Number of AUA students Rotating"; Text[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(67; "Number of students from other medical schools in that rotation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'Not in used';        //Due to field Length > 30      //08-09-2021
            ObsoleteState = Pending;
        }
        field(68; "Participates Morning Report"; Boolean)
        {
        }
        field(69; "Participates Daily Rounds"; Boolean)
        {
        }
        field(70; "Performs History"; Boolean)
        {
        }
        field(71; "Performs Physical"; Boolean)
        {
        }
        field(72; "Ambulatory Training"; Boolean)
        {
        }
        field(73; "Performs Procedures"; Boolean)
        {
        }
        field(74; "Writes/Types Orders"; Boolean)
        {
        }
        field(75; "EMR Entry"; Boolean)
        {
        }
        field(76; "Night Calls/Rotation"; Boolean)
        {
        }
        field(77; "Case Presentations"; Boolean)
        {
        }
        field(78; "General_Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Education Facilities"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Student Facilities"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Rating"; Option)
        {
            OptionMembers = " ","Excellent","Good","Average","Poor";
        }
        field(82; "GeneralComments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Approval"; Option)
        {
            OptionMembers = " ","Approved","Approved with Recommendations","Not Approved";
        }
        field(84; "Approval Comments"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Appr. ACGME Residency Prog."; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved ACGME Residency Program';
        }
        field(86; "Dept Chairperson Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Dept Chairperson Phone';
        }
        field(87; "Program Director Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Program Director Phone';
        }
        field(88; "Clerkship Director Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Clerkship Director Phone';
        }
        field(89; "AUA students Rotating"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of AUA students Rotating';
        }
        field(90; "Other Med. School Rotation"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of students from other medical schools in that rotation';
        }
        Field(91; "Speciality 1"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Speciality';
            OptionMembers = "Family Medicine","Internal Medicine",Surgery,Pediatrics,"Obstetrics and Gynecology",Psychiatry,Other;
        }
        field(92; "DME with Area Code"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(93; "Dept Chair. with Area Code"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dept Chairperson with Area Code';
        }
        field(94; "Program Director Area Code"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Program Director Area Code';
        }
        field(95; "Clerk. Direc. Area Code"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Director Area Code';
        }
        field(96; "Other Speciality"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(97; AttachmentExist; Boolean)//CSPL-00307- 20-01-2022
        {
            // DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = exist("Student Document Attachment" where("SLcM Document No" = field("Document No.")));
        }

    }


    keys
    {
        key(Key1; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        Inserted := true;
        "Inserted By" := UserId();
        "Inserted On" := Today();
        EducationSetupCS.Reset();
        If EducationSetupCS.FindFirst() then;

        IF "Document No." = '' then begin
            EducationSetupCS.TestField("Site Visit Nos");
            NoSeriesManagement.InitSeries(EducationSetupCS."Site Visit Nos", xRec."No. Series", 0D, "Document No.", Rec."No. Series");
        end;

    end;

    trigger OnModify()
    begin
        Updated := true;
        "Updated By" := UserId();
        "Updated On" := Today();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(OldSiteVisit: Record "Site Visit"): Boolean
    Var
        EducationSetupCS: Record "Education Setup-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        //Code added for lookup No. series::CSPL-00092::02-05-2019: Start
        WITH OldSiteVisit DO BEGIN
            OldSiteVisit := Rec;
            EducationSetupCS.Reset();
            IF EducationSetupCS.FindFirst() then;
            EducationSetupCS.TESTFIELD("Site Visit Nos");
            IF NoSeriesManagement.SelectSeries(EducationSetupCS."Site Visit Nos", OldSiteVisit."No. Series", "No. Series") THEN BEGIN
                NoSeriesManagement.SetSeries("Document No.");
                Rec := OldSiteVisit;
                EXIT(TRUE);
            END;
        END;
        //Code added for No. series::CSPL-00092::02-05-2019: Start
    end;



}